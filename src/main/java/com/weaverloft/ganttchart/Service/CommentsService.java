package com.weaverloft.ganttchart.Service;

import com.weaverloft.ganttchart.dto.Comments;

import java.util.List;

public interface CommentsService {
    List<Comments> findCommentByBoardNo(int boardNo) throws Exception;

    int createPreComment(Comments comments) throws Exception;

    int createSubComment(Comments comments) throws Exception;
    int changeOrders(int orders,int boardNo) throws Exception;

    List<Comments> findPreCommentByBoardNo(int boardNo) throws Exception;

    Comments findSameOrders(int orders, int boardNo, int groupNo) throws Exception;
}
