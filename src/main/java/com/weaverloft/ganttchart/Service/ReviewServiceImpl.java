package com.weaverloft.ganttchart.Service;

import com.weaverloft.ganttchart.dao.FilesDao;
import com.weaverloft.ganttchart.dao.ReviewDao;
import com.weaverloft.ganttchart.dto.Files;
import com.weaverloft.ganttchart.dto.Review;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class ReviewServiceImpl implements ReviewService{
    private ReviewDao reviewDao;
    private FilesDao filesDao;

    public ReviewServiceImpl(ReviewDao reviewDao,FilesDao filesDao) {
        this.reviewDao = reviewDao;
        this.filesDao = filesDao;
    }

    @Override
    public int createReview(Review review) throws Exception {
        return reviewDao.createReview(review);
    }

    @Override
    public List<Review> findReviewByGathNo(int gathNo) throws Exception {
        List<Review> reviews = reviewDao.findReviewByGathNo(gathNo);
        List<Review> reviewList = new ArrayList<>();
        for(int i=0;i<reviews.size();i++){
            Review review = reviews.get(i);
            List<Files> fileList = filesDao.findFileByReviewNo(review.getReviewNo());
            review.setFileList(fileList);
            reviewList.add(review);
        }
        return reviewList;
    }

    @Override
    public int findCurNo() throws Exception {
        return reviewDao.findCurNo();
    }

    @Override
    public Review findReviewByReviewNo(int reviewNo) throws Exception {
        Review review = reviewDao.findReviewByReviewNo(reviewNo);
        List<Files> fileList = filesDao.findFileByReviewNo(review.getReviewNo());
        review.setFileList(fileList);
        return review;
    }
}
