package com.weaverloft.ganttchart.Service;

import com.weaverloft.ganttchart.dao.CommentsDao;
import com.weaverloft.ganttchart.dto.Comments;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommentsServiceImpl implements CommentsService{
    private CommentsDao commentsDao;

    public CommentsServiceImpl(CommentsDao commentsDao) {
        this.commentsDao = commentsDao;
    }

    @Override
    public List<Comments> findCommentByBoardNo(int boardNo) throws Exception {
        return commentsDao.findCommentByBoardNo(boardNo);
    }

    @Override
    public int createPreComment(Comments comments) throws Exception {
        return commentsDao.createPreComment(comments);
    }

    @Override
    public int createSubComment(Comments comments) throws Exception {
        return commentsDao.createSubComment(comments);
    }

    @Override
    public int changeOrders(int orders, int boardNo) throws Exception {
        return commentsDao.changeOrders(orders,boardNo);
    }

    @Override
    public List<Comments> findPreCommentByBoardNo(int boardNo) throws Exception {
        return commentsDao.findPreCommentByBoardNo(boardNo);
    }

    @Override
    public int findSameOrders(Comments comments) throws Exception {
        return commentsDao.findSameOrders(comments);
    }

    @Override
    public int deleteCommentByNo(int commentsNo) throws Exception {
        return commentsDao.deleteCommentByNo(commentsNo);
    }

    @Override
    public int updateComment(Comments comments) throws Exception {
        return commentsDao.updateComment(comments);
    }

    @Override
    public int findSameDepth(Comments comments) throws Exception {
        return commentsDao.findSameDepth(comments);
    }

}
