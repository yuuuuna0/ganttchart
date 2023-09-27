package com.weaverloft.ganttchart.mapper;

import com.weaverloft.ganttchart.dto.Review;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ReviewMapper {
    int createReview(Review review) throws Exception;

    List<Review> findReviewByGathNo(int gathNo) throws Exception;

    int findCurNo() throws Exception;

    Review findReviewByReviewNo(int reviewNo) throws Exception;
}
