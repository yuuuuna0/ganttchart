package com.weaverloft.ganttchart.Service;

import com.weaverloft.ganttchart.dao.BoardDao;
import com.weaverloft.ganttchart.dto.Board;
import com.weaverloft.ganttchart.util.PageMaker;
import com.weaverloft.ganttchart.util.PageMakerDto;
import org.springframework.aop.scope.ScopedProxyUtils;
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
    public PageMakerDto<Board> findBoardList(int pageNo,String keyword) throws Exception {
        int totBoardCount=boardDao.findBoardCount(keyword);    //전체 글 개수 --> 조건에 맞는 개수의 전체 계산해야함
        PageMaker pageMaker=new PageMaker(totBoardCount,pageNo);    //page 계산
        //게시글 데이터 얻기
        List<Board> boardList=boardDao.findBoardList(pageMaker.getPageBegin(),pageMaker.getPageEnd(),keyword);
        PageMakerDto<Board> pageMakerBoardList=new PageMakerDto<Board>(boardList,pageMaker,totBoardCount);
        return pageMakerBoardList;
    }
    //3. 게시글 상세보기
    @Override
    public Board findByBoardNo(int boardNo) throws Exception {
        Board board=boardDao.findByBoardNo(boardNo);
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

    @Override
    public int updateBoardReadcount(int boardNo) throws Exception {
        int result=boardDao.updateBoardReadcount(boardNo);
        return result;
    }

    @Override
    public int findCurKey() throws Exception {
        return boardDao.findCurKey();
    }

    @Override
    public List<Board> findBoardTopList(int no) throws Exception{
        return boardDao.findBoardTopList(no);
    }

}
