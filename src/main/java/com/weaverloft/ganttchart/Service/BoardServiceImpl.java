package com.weaverloft.ganttchart.Service;

import com.weaverloft.ganttchart.dao.BoardDao;
import com.weaverloft.ganttchart.dto.Board;
import com.weaverloft.ganttchart.dto.Users;
import com.weaverloft.ganttchart.util.PageMaker;
import com.weaverloft.ganttchart.util.SearchDto;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class BoardServiceImpl implements BoardService{
    private BoardDao boardDao;

    public BoardServiceImpl(BoardDao boardDao) {
        this.boardDao = boardDao;
    }

    @Override
    public List<Board> findBoardList() throws Exception {
        return boardDao.findBoardList();
    }

    @Override
    public Board findBoardByNo(int boardNo) throws Exception {
        return boardDao.findBoardByNo(boardNo);
    }

    @Override
    public int findCurNo() throws Exception {
        return boardDao.findCurNo();
    }

    @Override
    public int createBoard(Board board) throws Exception {
        return boardDao.createBoard(board);
    }

    @Override
    public int increaseReadCount(int boardNo) throws Exception {
        return boardDao.increaseReadCount(boardNo);
    }

    @Override
    public int updateBoard(Board board) throws Exception {
        return boardDao.updateBoard(board);
    }

    @Override
    public List<Board> findBoardByUId(String uId) throws Exception {
        return boardDao.findBoardByUId(uId);
    }

    @Override
    public List<Board> findTopNBoard(int index) throws Exception {
        return boardDao.findTopNBoard(index);
    }

    @Override
    public SearchDto<Board> findSearchedUserList(int pageNo, String keyword, String filterType, String ascDesc) throws Exception {
        //조건에 맞는 전체 사용자 수
        int totBoardCount = boardDao.countBoard(keyword);
        //페이지네이션에 필요한 변수들 얻기
        PageMaker pageMaker = new PageMaker(totBoardCount,pageNo);
        //페이징&필터된 데이터 얻기
        List<Board> boardList = boardDao.findBoardList2(pageMaker.getContentBegin(),pageMaker.getContentEnd(),keyword,filterType,ascDesc);
        SearchDto<Board> searchBoardList = new SearchDto<Board>(boardList,pageMaker,totBoardCount);
        return searchBoardList;
    }

    @Override
    public int countNewBoardPerDay(Date time) throws Exception {
        return boardDao.countNewBoardPerDay(time);
    }

    @Override
    public int deleteBoard(int boardNo) throws Exception {
        return boardDao.deleteBoard(boardNo);
    }
}
