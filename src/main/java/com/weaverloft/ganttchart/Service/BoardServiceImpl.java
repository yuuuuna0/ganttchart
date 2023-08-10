package com.weaverloft.ganttchart.Service;

import com.weaverloft.ganttchart.dao.BoardDao;
import com.weaverloft.ganttchart.dto.Board;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
@Service
public class BoardServiceImpl implements BoardService {
    private BoardDao boardDao;

    public BoardServiceImpl(BoardDao boardDao) {
        this.boardDao = boardDao;
    }
    //1. 게시글 쓰기
    @Override
    public int createBoard(Board board) throws Exception {
        int result=boardDao.createBoard(board);
        return result;
    }
    //2. 게시글 전체 리스트 보기 --> 페이징처리 필요
    @Override
    public List<Board> selectBoardList() throws Exception {
        List<Board> boardList= new ArrayList<Board>();
        boardList=boardDao.selectBoardList();
        return boardList;
    }
    //3. 게시글 상세보기
    @Override
    public Board selectByBoardNo(int boardNo) throws Exception {
        Board board=boardDao.selectByBoardNo(boardNo);
        return board;
    }
    //4. 게시글 삭제
    @Override
    public int deleteBoard(int boardNo) throws Exception {
        int result=boardDao.deleteBoard(boardNo);
        return result;
    }
    //5. 게시글 수정
    @Override
    public int updateBoard(Board board) throws Exception {
        int result=boardDao.updateBoard(board);
        return result;
    }
}
