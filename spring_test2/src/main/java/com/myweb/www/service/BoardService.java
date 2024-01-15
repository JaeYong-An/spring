package com.myweb.www.service;

import java.util.List;

import com.myweb.www.domain.BoardDTO;
import com.myweb.www.domain.BoardVO;
import com.myweb.www.domain.PagingVO;

public interface BoardService {

	int insert(BoardDTO boardDTO);

	List<BoardVO> getList(PagingVO pgvo);

	BoardDTO getDetail(long bno);

	int modify(BoardDTO boardDTO);

	int remove(int bno);

	int getTotalCount(PagingVO pgvo);

	int deleteFile(String uuid);

}
