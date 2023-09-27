package com.weaverloft.ganttchart.Service;

import com.weaverloft.ganttchart.dto.Review;

import java.util.List;

public interface ReviewService {
    int createReview(Review review) throws Exception;

    List<Review> findReviewByGathNo(int gathNo) throws Exception;

    int findCurNo() throws Exception;

    Review findReviewByReviewNo(int reviewNo) throws Exception;
}
