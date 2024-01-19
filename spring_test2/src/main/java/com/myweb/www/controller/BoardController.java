package com.myweb.www.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.myweb.www.domain.BoardDTO;
import com.myweb.www.domain.BoardVO;
import com.myweb.www.domain.FileVO;
import com.myweb.www.domain.PagingVO;
import com.myweb.www.handler.FileHandler;
import com.myweb.www.handler.PagingHandler;
import com.myweb.www.service.BoardService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/board/*")
@Controller
@RequiredArgsConstructor
public class BoardController {

	private final BoardService bsv;
	
	private final FileHandler fh;
	
	@GetMapping("/register")
	public void register() {}
	
	@PostMapping("/register")
	public String insert(BoardVO bvo, @RequestParam(name="files", required = false)MultipartFile[] files) {
		log.info(">>>> bvo>>> {}"+bvo);
		List<FileVO> flist = null;
		
		//FileHandler 생성 multipartfile -> flist
		if(files[0].getSize() > 0) {
			flist = fh.uploadFiles(files);
		}
		
		
		bsv.insert(new BoardDTO(bvo, flist));
		return "index";
	}
	
	@GetMapping("/list")
	public void list(Model m, PagingVO pgvo) {
		log.info(">>>> pgvo << {} "+pgvo);
		
		//페이징 처리
		List<BoardVO> list = bsv.getList(pgvo);
		//totalCount 구하기
		int totalCount = bsv.getTotalCount(pgvo);
		PagingHandler ph = new PagingHandler(pgvo, totalCount);
		m.addAttribute("list", list);
		m.addAttribute("ph",ph);
	}
	
	@GetMapping({"/detail","/modify"})
	public void detail(Model m, @RequestParam("bno")long bno) {
		log.info(">>>> bno>>>{}"+bno);
		m.addAttribute("bdto", bsv.getDetail(bno));
	}
	
	@PostMapping("/modify")
	public String modify(BoardVO bvo, @RequestParam(name="files", required = false)MultipartFile[] files) {
		List<FileVO> flist = null;
		if(files[0].getSize() > 0) {
			flist = fh.uploadFiles(files);
		}
		BoardDTO bdto = new BoardDTO(bvo, flist);
		bsv.modify(bdto);
		return "redirect:/board/detail?bno="+bvo.getBno();
	}
	
	@GetMapping("/remove")
	public String remove(@RequestParam("bno") int bno, RedirectAttributes re) {
		log.info(">>>> bno >> {}"+bno);
		int isOK = bsv.remove(bno);
		//페이지가 새로고침 될 때 남아있을 필요가 없는 데이터
		//리다이렉트 될 때 데이터를 보내는 객체(RedirectAttribute)
		//한번만 일회성으로 데이터 보낼 때 사용
		re.addFlashAttribute("isDel", isOK);
		return "redirect:/board/list";
	}
	
	@DeleteMapping(value="/file/{uuid}", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> deleteFile(@PathVariable("uuid")String uuid) {
		int isOK = bsv.deleteFile(uuid);
		return isOK>0 ? new ResponseEntity<String>("1", HttpStatus.OK) : new ResponseEntity<String>("0", HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
