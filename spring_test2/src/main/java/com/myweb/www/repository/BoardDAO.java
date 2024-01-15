package com.myweb.www.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.myweb.www.domain.BoardDTO;
import com.myweb.www.domain.BoardVO;
import com.myweb.www.domain.PagingVO;

public interface BoardDAO {

	int insert(BoardVO boardVO);

	List<BoardVO> getList(PagingVO pgvo);

	BoardVO getDetail(long bno);

	int modify(BoardVO bvo);

	int delete(int bno);

	int getTotalCount(PagingVO pgvo);
	
	void commentCount();

	long selectOneBno();

	void upRead(@Param("bno")long bno, @Param("i")int i);

	void upFile(long bno);

	void commentQtyUp(long bno);

	void updateCmt();

	void updateFile();

}