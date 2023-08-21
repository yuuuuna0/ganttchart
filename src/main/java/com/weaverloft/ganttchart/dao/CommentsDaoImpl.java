package com.weaverloft.ganttchart.dao;

import com.weaverloft.ganttchart.dto.Comments;
import com.weaverloft.ganttchart.mapper.CommentsMapper;
import org.apache.commons.math3.optim.nonlinear.scalar.GoalType;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class CommentsDaoImpl implements CommentsDao {
    private CommentsMapper commentsMapper;

    public CommentsDaoImpl(CommentsMapper commentsMapper) {
        this.commentsMapper = commentsMapper;
    }

    @Override
    public List<Comments> findCommentsByBoardNo(int boardNo) throws Exception {
        Map<String,Object> map = new HashMap<>();
        map.put("boardNo",boardNo);
        List<Comments> commentsList = commentsMapper.findCommentsByBoardNo(map);
        return commentsList;
    }

    @Override
    public Comments findCommentsByCommentsNo(int CommentsNo) throws Exception {
        return null;
    }

    @Override
    public int createComments(Comments comments) throws Exception{
        return commentsMapper.createComments(comments);
    }

    @Override
    public int findCommentsCountByGroupNo(int groupNo) throws Exception{
        return commentsMapper.findCommentsCountByGroupNo(groupNo);
    }

    @Override
    public int findCurCommentsNo() throws Exception {
        return commentsMapper.findCurCommentsNo();
    }

    @Override
    public int updateGroupNo(int curKey) {
        return commentsMapper.updateGroupNo(curKey);
    }
}
