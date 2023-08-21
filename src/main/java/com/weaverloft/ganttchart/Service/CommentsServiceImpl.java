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
    public List<Comments> findCommentsByBoardNo(int boardNo) throws Exception {
        List<Comments> commentsList = commentsDao.findCommentsByBoardNo(boardNo);
        return commentsList;
    }

    @Override
    public int createComments(Comments comments) throws Exception {
        int result = commentsDao.createComments(comments);
        return result;
    }

    @Override
    public int findCommentsCountByGroupNo(int groupNo) throws Exception{
        return commentsDao.findCommentsCountByGroupNo(groupNo);
    }

    @Override
    public int findCurCommentsNo() throws Exception {
        return commentsDao.findCurCommentsNo();
    }

    @Override
    public int updateGroupNo(int curKey) throws Exception{
        return commentsDao.updateGroupNo(curKey);
    }

    @Override
    public int deleteComments(int commentsNo) throws Exception{
        return commentsDao.deleteComments(commentsNo);
    }

    @Override
    public Comments findCommentByCommentsNo(int commentsNo) throws Exception{
        return commentsDao.findCommentByCommentsNo(commentsNo);
    }

    @Override
    public int updateComments(int commentsNo,String commentsContent) throws Exception {
        return commentsDao.updateComments(commentsNo,commentsContent);
    }
}
