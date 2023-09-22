package com.weaverloft.ganttchart.dao;


import com.weaverloft.ganttchart.dto.Comments;
import com.weaverloft.ganttchart.mapper.CommentsMapper;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class CommentsDaoImpl implements CommentsDao{
    private CommentsMapper commentsMapper;

    public CommentsDaoImpl(CommentsMapper commentsMapper) {
        this.commentsMapper = commentsMapper;
    }

    @Override
    public List<Comments> findCommentByBoardNo(int boardNo) throws Exception {
        return commentsMapper.findCommentByBoardNo(boardNo);
    }

    @Override
    public int createPreComment(Comments comments) throws Exception {
        return commentsMapper.createPreComment(comments);
    }

    @Override
    public int createSubComment(Comments comments) throws Exception {
        return commentsMapper.createSubComment(comments);
    }

    @Override
    public int changeOrders(int orders, int boardNo) throws Exception {
        Map<String,Object> map = new HashMap<>();
        map.put("orders",orders);
        map.put("boardNo",boardNo);
        return commentsMapper.changeOrders(map);
    }

    @Override
    public List<Comments> findPreCommentByBoardNo(int boardNo) throws Exception {
        return commentsMapper.findPreCommentByBoardNo(boardNo);
    }

    @Override
    public int findSameOrders(Comments comments) throws Exception {
        return commentsMapper.findSameOrders(comments);
    }

    @Override
    public int deleteCommentByNo(int commentsNo) throws Exception {
        return commentsMapper.deleteCommentByNo(commentsNo);
    }

    @Override
    public int updateComment(Comments comments) throws Exception {
        return commentsMapper.updateComment(comments);
    }

    @Override
    public int findSameDepth(Comments comments) throws Exception {
        return commentsMapper.findSameDepth(comments);
    }

}
