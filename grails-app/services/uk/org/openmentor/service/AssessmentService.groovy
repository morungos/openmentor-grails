package uk.org.openmentor.service

import java.util.Collection;
import java.util.Map;

import uk.org.openmentor.data.Submission;
import uk.org.openmentor.domain.Categorization;
import uk.org.openmentor.domain.Category;
import uk.org.openmentor.domain.DataBook;
import uk.org.openmentor.domain.DataSheet;
import uk.org.openmentor.domain.Grade;
import uk.org.openmentor.evaluator.EvaluationScheme;

/**
 * The AssessmentService is responsible for converting data-backed comment sets into
 * tables and data that can be displayed in views. It could be argued that this belongs
 * as a domain object, but that isn't really appropriate (in Grails) as it spans
 * virtually the whole domain layer. 
 * 
 * @author stuart
 */

class AssessmentService {

    static transactional = true
	
	EvaluationScheme evaluationComponent
	
	/**
	 * Returns a Categorization constructed from a single submission. 
	 * @param submission
	 * @return a Categorization
	 */
	public Categorization getCategorization(Submission submission) {
		return getCategorization([submission] as Set<Submission>)
    }
	
	/**
	 * Returns a Categorization constructed from a set of submissions. 
	 * @param submission
	 * @return a Categorization
	 */
	public Categorization getCategorization(Set<Submission> submissions) {
		Categorization ctgz = new Categorization()
		ctgz.clear()
		ctgz.addComments(submissions)
		
		return ctgz
    }
	
	private Map<String, Integer> getCommentCounts(Categorization ctgz) {
		List<String> categories = Category.getCategories()

		Map<String, Integer> actualCounts = new HashMap<String,Integer>();
		for (String category: categories) {
			int n = ctgz.getCommentCount(category);
			actualCounts.put(category, n);
		}
		
		return actualCounts
	}
	
	private Integer getValuesTotal(Collection<Integer> values) {
		return values.sum(0)
	}
	
	/**
	 * Builds a DataBook for charting purposes, based on a single submission. 
	 * @return  the DataBook instance
	 */
	public final DataBook buildDataBook(Submission submission) {
		return buildDataBook([submission] as Set<Submission>)
	}
	
	/**
	 * Builds a DataBook for charting purposes, based on a set of submissions. 
	 * @return  the DataBook instance
	 */
	public final DataBook buildDataBook(Set<Submission> submissions) {
		Categorization ctgz = getCategorization(submissions)
		return buildDataBook(ctgz)
	}
		
	/**
	 * Builds a DataBook for charting purposes, based on a categorization
	 * constructed from the set of submissions.
	 *  
	 * @return  the DataBook instance
	 */
	public final DataBook buildDataBook(Categorization ctgz) {
		DataBook dataBook = new DataBook();
		Map<String, Integer> actualCounts = getCommentCounts(ctgz)
		Integer commentCount = getValuesTotal(actualCounts.values())
		log.debug("Actual coment counts: " + actualCounts)
		log.debug("Total coment count: " + commentCount)
		
		List<String> categories = Category.getCategories()
		List<String> bands = Category.getBands()
		Map<String, String> categoryBandMap = Category.getCategoryBandMap()
		
		Map<String, List<String>> comments = new HashMap<String, List<String>>();
		for (String category: categories) {
			log.debug("Comment: " + category + ", " + ctgz.getComments(category))
			comments.put(category, ctgz.getComments(category));
		}
		Map<String, List<String>> aggregateComments = aggregateComments(comments);
		List<List<String>> commentsList = bands.collect { a -> aggregateComments.get(a) }
		
		Map<String, Integer> submissionCounts = ctgz.getSubmissionCounts();
		Map<String, Number> idealCounts = weightedIdealCounts(submissionCounts);
		Map<String, Number> actualAggregateCounts = aggregateBands(actualCounts);
		
		int submissionCount = 0;
		submissionCounts.each { key, value -> submissionCount += value }
		Double factor = commentCount / submissionCount;
		
		Map<String, Number> idealAggregateCounts = new HashMap<String, Number>();
		idealCounts.each { key, value -> idealAggregateCounts.put(key, value * factor) }
		
		dataBook.setDataPoints(bands);
		dataBook.setDataSeries("IdealCounts", toList(bands, idealAggregateCounts));
		dataBook.setDataSeries("ActualCounts", toList(bands, actualAggregateCounts));
		dataBook.setDataSeries("ActualComments", commentsList);
		dataBook.setProperty("SubmissionCount", new Integer(submissionCount))
		dataBook.setProperty("CommentCount", new Integer(commentCount))
		return dataBook;
	}
	
	/**
     * We work internally with maps, indexed by Category; externally
     * we prefer a list arranged in the same Category order as that
     * provided by the DescriptorFactory; this methods does the
     * conversion.
     *
     * @param map the given map indexed by Categories;
     * @return the corresponding list.
     */
    private List<Number> toList(List<String> categories, Map <String, Number> map) {
        List l = new ArrayList<Number>();
        for (String category : categories) {
            l.add(map.get(category));
        }
        return l;
    }
	
	private Map<String, Number> aggregateBands(Map<String, Number> count) {
		Map<String, Number> expected = new HashMap<String, Number>();
		Map<String, String> categoryBands = Category.getCategoryBandMap()
		for (String category : Category.getCategories() ) {
			String band = categoryBands.get(category);
			Number value = count.get(category)
			if (! expected.containsKey(band)) {
				expected.put(band, value);
			} else {
				expected.put(band, expected.get(band) + value)
			}
		}
		return expected
	}
	
	private Map<String, List<String>> aggregateComments(Map<String, List<String>> comments) {
		Map<String, List<String>> result = new HashMap<String, List<String>>();
		Map<String, String> categoryBands = Category.getCategoryBandMap()
		for (String category : Category.getCategories() ) {
			String band = categoryBands.get(category);
			List<String> value = comments.get(category)
			if (! result.containsKey(band)) {
				result.put(band, value.clone());
			} else {
				result.get(band).addAll(value)
			}
		}
		return result
	}
	
    /**
     * Returns a list of Submissions which will be used to build the
     * report.  This is the *only* place the submissionId, id and
     * reportFor parameters are now to be used.
     *
     * @return a <code>List</code> value
     */
    private Map<String, Number> weightedIdealCounts(Map<String, Integer> count) {
        Map<String, Number> expected = new HashMap<String, Integer>();
        for (String band : Category.getBands() ) {
            Number sum = 0.0;
            for (String grade : Grade.getGrades()) {
                sum += count.get(grade) * evaluationComponent.getIdealProportion(band, grade);
            }
            expected.put(band, sum);
            if (log.isDebugEnabled()) {
                log.debug("weightedIdealCounts: " + band + ", " + sum);
            }
        }
        return expected;        
    }
}
