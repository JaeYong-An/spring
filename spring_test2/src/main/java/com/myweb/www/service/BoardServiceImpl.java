package com.myweb.www.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.myweb.www.domain.BoardDTO;
import com.myweb.www.domain.BoardVO;
import com.myweb.www.domain.FileVO;
import com.myweb.www.domain.PagingVO;
import com.myweb.www.repository.BoardDAO;
import com.myweb.www.repository.FileDAO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service
public class BoardServiceImpl implements BoardService{

	
	private final BoardDAO bdao;
	
	private final FileDAO fdao;

	@Override
	public int insert(BoardDTO boardDTO) {
		log.info("insert service in");
		// TODO Auto-generated method stub
		int isOK = bdao.insert(boardDTO.getBvo());
		
		if(boardDTO.getFlist()==null) {
			return isOK;
		}
		//bvo insert후 파일도 있다면...
		if(isOK>0 && boardDTO.getFlist().size()>0) {
			long bno = bdao.selectOneBno();
			for(FileVO fvo : boardDTO.getFlist()) {
				fvo.setBno(bno);
				fdao.insert(fvo);
				bdao.upFile(boardDTO.getBvo().getBno());
			}
		}
		return isOK;
	}

	@Transactional
	@Override
	public List<BoardVO> getList(PagingVO pgvo) {
		// TODO Auto-generated method stub
		bdao.updateCmt();
		bdao.updateFile();
		return bdao.getList(pgvo);
	}

	@Transactional
	@Override
	public BoardDTO getDetail(long bno) {
		// TODO Auto-generated method stub
		bdao.upRead(bno, 1);
		BoardVO bvo = bdao.getDetail(bno);
		List<FileVO> flist = fdao.getFileList(bno);
		BoardDTO bdto = new BoardDTO(bvo, flist);
		return bdto;
	}

	@Transactional
	@Override
	public int modify(BoardDTO boardDTO) {
		// TODO Auto-generated method stub
		bdao.upRead(boardDTO.getBvo().getBno(), -2);
		int isOK = bdao.modify(boardDTO.getBvo());
		if(boardDTO.getFlist()==null) {
			return isOK;
		}
		//bvo insert후 파일도 있다면...
		if(isOK>0 && boardDTO.getFlist().size()>0) {
			long bno = bdao.selectOneBno();
			for(FileVO fvo : boardDTO.getFlist()) {
				fvo.setBno(bno);
				fdao.insert(fvo);
			}
		}
		return isOK;
	}

	@Override
	public int remove(int bno) {
		// TODO Auto-generated method stub
		return bdao.delete(bno);
	}

	@Override
	public int getTotalCount(PagingVO pgvo) {
		// TODO Auto-generated method stub
		return bdao.getTotalCount(pgvo);
	}

	@Override
	public int deleteFile(String uuid) {
		// TODO Auto-generated method stub
		return fdao.delete(uuid);
	}
}
