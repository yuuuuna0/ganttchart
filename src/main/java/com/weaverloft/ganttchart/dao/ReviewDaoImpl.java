package com.weaverloft.ganttchart.dao;

import com.weaverloft.ganttchart.dto.Review;
import com.weaverloft.ganttchart.mapper.ReviewMapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ReviewDaoImpl implements ReviewDao{
    private ReviewMapper reviewMapper;

    public ReviewDaoImpl(ReviewMapper reviewMapper) {
        this.reviewMapper = reviewMapper;
    }

    @Override
    public int createReview(Review review) throws Exception {
        return reviewMapper.createReview(review);
    }

    @Override
    public List<Review> findReviewByGathNo(int gathNo) throws Exception {
        return reviewMapper.findReviewByGathNo(gathNo);
    }
}
