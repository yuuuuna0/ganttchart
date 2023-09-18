package com.weaverloft.ganttchart.mapper;

import com.weaverloft.ganttchart.dto.Comments;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface CommentsMapper {
    List<Comments> findCommentByBoardNo(int boardNo) throws Exception;
    int createPreComment(Comments comments) throws Exception;
    int createSubComment(Comments comments) throws Exception;
    int changeOrders(Map<String,Object> map) throws Exception;

    List<Comments> findPreCommentByBoardNo(int boardNo) throws Exception;

    Comments findSameOrders(Map<String,Object> map) throws Exception;
}
