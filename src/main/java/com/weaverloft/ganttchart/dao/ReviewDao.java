package com.weaverloft.ganttchart.dao;

import com.weaverloft.ganttchart.dto.Review;

import java.util.List;

public interface ReviewDao {
    int createReview(Review review) throws Exception;

    List<Review> findReviewByGathNo(int gathNo) throws Exception;
}
