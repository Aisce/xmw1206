package net.shopxx.controller.member;

import net.shopxx.Results;
import net.shopxx.entity.Member;
import net.shopxx.entity.Member.RealnameStatus;
import net.shopxx.security.CurrentUser;
import net.shopxx.service.MemberService;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

@Controller("memberRealnameController")
@RequestMapping("/member/realname")
public class RealnameController extends BaseController {

	@Inject
	private MemberService memberService;
	
	@GetMapping("/edit")
	public String edit(@CurrentUser Member currentUser) {
		if (currentUser.getAttestationFlag() != null) {
			if(currentUser.getAttestationFlag().equals(Member.RealnameStatus.REAL)){ // 已认证成功
				return "member/realname/success";
			}
		}
		return "member/realname/edit";
	}

	@PostMapping("/update")
	public ResponseEntity<?> update(Member member,@CurrentUser Member currentUser, HttpServletRequest request) {
		if (currentUser.getAttestationFlag() != null && currentUser.getAttestationFlag().equals(Member.RealnameStatus.REAL)) { // 已认证成功
			return Results.unprocessableEntity("member.realname.realExist");
		}
		RealnameStatus valueOf = Member.RealnameStatus.valueOf("REALING");
		currentUser.setName(member.getName());
		currentUser.setPhoto1(member.getPhoto1());
		currentUser.setPhoto2(member.getPhoto2());
		currentUser.setPhoto3(member.getPhoto3());
		currentUser.setAttestationFlag(valueOf);//zhuangtai
		currentUser.setIdcard(member.getIdcard());
		currentUser.setUnitName(member.getUnitName());
		currentUser.setUnitAddress(member.getUnitAddress());

		memberService.update(currentUser);
		return Results.OK;
	}
}
