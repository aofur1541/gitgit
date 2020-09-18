package com.kdis.PROM.apply.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kdis.PROM.apply.dao.VMDAO;
import com.kdis.PROM.apply.vo.ApprovalWorkflowVO;
import com.kdis.PROM.apply.vo.VMCDROMVO;
import com.kdis.PROM.apply.vo.VMCreateVO;
import com.kdis.PROM.apply.vo.VMDataVO;
import com.kdis.PROM.apply.vo.VMDiskVO;
import com.kdis.PROM.apply.vo.VMNetworkVO;
import com.kdis.PROM.common.CommonUtil;
import com.kdis.PROM.common.Constants;
import com.kdis.PROM.login.util.LoginSessionUtil;
import com.kdis.PROM.tenant.vo.TenantVO;
import com.kdis.PROM.tenant.vo.VMServiceVO;
import com.kdis.PROM.user.vo.UserVO;

/**
 * 가상머신 서비스 구현 class
 * 
 * @author KimHahn
 *
 */
@Service
public class VMServiceImpl implements VMService {

	/** 가상머신 DAO */
	@Autowired
	VMDAO vmDAO;
	
	
	@Override
	public void updateVmDataComment(VMDataVO dbVMData) {
		 vmDAO.updateVmDataComment(dbVMData);
		
	}
	
	
	
	
	
	
	
	/**
	 * 가상머신 목록 조회
	 * 
	 * @param vmDataVO
	 * @return
	 */
	@Override
	public List<VMDataVO> selectVMDataList(VMDataVO vmDataVO) {
		return vmDAO.selectVMDataList(vmDataVO);
	}
	
	/**
	 * 사용자가 속한 가상머신 목록 조회
	 * 
	 * @param vmDataVO
	 * @return
	 */
	@Override
	public List<VMDataVO> selectVMDataListByUserMapping(VMDataVO vmDataVO) {
		return vmDAO.selectVMDataListByUserMapping(vmDataVO);
	}
	
	/**
	 * 서비스에 배치된 가상머신 목록 조회
	 * 
	 * @return
	 */
	@Override
	public List<VMDataVO> selectArrangedVMList() {
		return vmDAO.selectArrangedVMList();
	}
	
	/**
	 * 서비스에 배치 안된 가상머신 목록 조회
	 * 
	 * @return
	 */
	@Override
	public List<VMDataVO> selectUnarrangedVMList() {
		return vmDAO.selectUnarrangedVMList();
	}
	
	/**
	 * 가상머신 템플릿 목록 조회
	 * 
	 * @return
	 */
	@Override
	public List<VMDataVO> selectVMTemplateList() {
		return vmDAO.selectVMTemplateList();
	}
	
	/**
	 * ON인 가상머신 템플릿 목록 조회
	 * 
	 * @param searchParam 검색어
	 * @param sort 정렬:AES, DESC
	 * @return
	 */
	@Override
	public List<VMDataVO> selectVMTemplateOnList(String searchParam, String sort) {
		VMDataVO vmDataVO = new VMDataVO();
		vmDataVO.setSearchParam(CommonUtil.nullToBlank(searchParam));
		vmDataVO.setSort(CommonUtil.nullToBlank(sort));
		return vmDAO.selectVMTemplateOnList(vmDataVO);
	}
	
	/**
	 * 가상머신 조회
	 * 
	 * @param vmID 가상머신 아이디
	 * @return
	 */
	@Override
	public VMDataVO selectVMData(String vmID) {
		VMDataVO vmDataVO = new VMDataVO();
		vmDataVO.setVmID(vmID);
		return vmDAO.selectVMData(vmDataVO);
	}
	
	/**
	 * 가상머신명으로 가상머신 조회
	 * 
	 * @param vmName 가상머신명
	 * @return
	 */
	@Override
	public VMDataVO selectVMDataByVMName(String vmName) {
		VMDataVO vmDataVO = new VMDataVO();
		vmDataVO.setVmName(vmName);
		return vmDAO.selectVMData(vmDataVO);
	}
	
	/**
	 * 가상머신 생성 신청 목록 조회
	 * 
	 * @param vmCreateVO 검색 조건
	 * @return
	 */
	@Override
	public List<VMCreateVO> selectApplyVMList(VMCreateVO vmCreateVO) {
		return vmDAO.selectApplyVMList(vmCreateVO);
	}
	
	/**
	 * 사용자와 매핑된 서비스 그룹의 가상머신 생성 신청 목록 조회
	 * 
	 * @param vmCreateVO 검색 조건
	 * @return
	 */
	@Override
	public List<VMCreateVO> selectApplyVMListByUserMapping(VMCreateVO vmCreateVO) {
		return vmDAO.selectApplyVMListByUserMapping(vmCreateVO);
	}
	
	/**
	 * 가상머신 생성 조회
	 * 
	 * @param vmCreateVO 검색 조건
	 * @return
	 */
	@Override
	public VMCreateVO selectVMCreate(VMCreateVO vmCreateVO) {
		return vmDAO.selectVMCreate(vmCreateVO);
	}
	
	/**
	 * 가상머신 반환 신청 개수 조회
	 * 
	 * @param vmName 가상머신명
	 * @return
	 */
	@Override
	public int countVMReturn(String vmName) {
		VMCreateVO vmCreateVO = new VMCreateVO();
		vmCreateVO.setCrVMName(vmName);
		return vmDAO.countVMReturn(vmCreateVO);
	}
	
	/**
	 * 가상머신 승인 Workflow 목록 조회
	 * 
	 * @param crNum 가상머신 생성 ID
	 * @param stage 단계
	 * @return
	 */
	@Override
	public List<ApprovalWorkflowVO> selectApprovalWorkflowList(Integer crNum, Integer stage) {
		ApprovalWorkflowVO approvalWorkflowVO = new ApprovalWorkflowVO();
		approvalWorkflowVO.setCrNum(crNum);
		approvalWorkflowVO.setStage(stage);
		return vmDAO.selectApprovalWorkflowList(approvalWorkflowVO);
	}
	
	/**
	 * 가상머신 생성 등록
	 * 
	 * @param vmCreateVO
	 * @return
	 */
	@Override
	@Transactional
	public int insertVMCreate(VMCreateVO vmCreateVO) {
		return vmDAO.insertVMCreate(vmCreateVO);
	}
	
	/**
	 * 가상머신 생성 승인 단계 수정
	 * 
	 * @param crNum
	 * @param crApproval
	 * @return
	 */
	@Override
	@Transactional
	public int updateVMCreateApproval(Integer crNum, Integer crApproval) {
		VMCreateVO vmCreateVO = new VMCreateVO();
		vmCreateVO.setCrNum(crNum);
		vmCreateVO.setCrApproval(crApproval);
		return vmDAO.updateVMCreateApproval(vmCreateVO);
	}
	
	/**
	 * 가상머신 생성 승인 단계 수정
	 * 
	 * @param crNum
	 * @param crApproval
	 * @param crIPAddress
	 * @return
	 */
	@Override
	@Transactional
	public int updateVMCreateApproval(Integer crNum, Integer crApproval, String crIPAddress) {
		VMCreateVO vmCreateVO = new VMCreateVO();
		vmCreateVO.setCrNum(crNum);
		vmCreateVO.setCrApproval(crApproval);
		vmCreateVO.setCrIPAddress(crIPAddress);
		return vmDAO.updateVMCreateApproval(vmCreateVO);
	}
	
	/**
	 * 가상머신 생성/변경 보류
	 * 
	 * @param crNum
	 * @param crComment
	 * @return
	 */
	@Override
	@Transactional
	public int holdVMCreate(Integer crNum, String crComment) {
		VMCreateVO vmCreateVO = new VMCreateVO();
		vmCreateVO.setCrNum(crNum);
		vmCreateVO.setCrComment(crComment);
		return vmDAO.holdVMCreate(vmCreateVO);
	}
	
	/**
	 * 가상머신 생성/변경/반환 반려
	 * 
	 * @param crNum
	 * @param crComment
	 * @return
	 */
	@Override
	@Transactional
	public int rejectVMCreate(Integer crNum, String crComment) {
		VMCreateVO vmCreateVO = new VMCreateVO();
		vmCreateVO.setCrNum(crNum);
		vmCreateVO.setCrComment(crComment);
		return vmDAO.rejectVMCreate(vmCreateVO);
	}
	
	/**
	 * 가상머신 승인 Workflow 등록
	 * 
	 * @param approvalWorkflowVO
	 * @return
	 */
	@Override
	@Transactional
	public int insertApprovalWorkflow(ApprovalWorkflowVO approvalWorkflowVO) {
		return vmDAO.insertApprovalWorkflow(approvalWorkflowVO);
	}
	
	/**
	 * 가상머신 승인 Workflow 수정
	 * 
	 * @param approvalWorkflowVO
	 * @return
	 */
	@Override
	@Transactional
	public int updateApprovalWorkflow(ApprovalWorkflowVO approvalWorkflowVO) {
		return vmDAO.updateApprovalWorkflow(approvalWorkflowVO);
	}
	
	/**
	 * 가상머신 생성 정보로 가상머신 승인 Workflow 등록
	 * 
	 * @param vmCreateVO
	 */
	@Override
	@Transactional
	public void insertApprovalWorkflow(VMCreateVO vmCreateVO) {

		// 가상머신 승인 Workflow 등록
		ApprovalWorkflowVO approvalWorkflowVO = new ApprovalWorkflowVO();

		approvalWorkflowVO.setsUserID(vmCreateVO.getCrUserID());
		approvalWorkflowVO.setCrNum(vmCreateVO.getCrNum());
		approvalWorkflowVO.setDescription(vmCreateVO.getCrVMContext());
		approvalWorkflowVO.setStage(this.getStage());
		approvalWorkflowVO.setStatus(3);

		this.insertApprovalWorkflow(approvalWorkflowVO);
		
		// 가상머신 생성 정보에 승인 상태 수정
		this.updateVMCreateApproval(vmCreateVO.getCrNum(), this.getStage());
	}
	
	/**
	 * 가상머신 Disk 목록 조회
	 * 
	 * @param vmDiskVO 검색 조건
	 * @return
	 */
	@Override
	public List<VMDiskVO> selectVMDiskList(VMDiskVO vmDiskVO) {
		return vmDAO.selectVMDiskList(vmDiskVO);
	}
	
	/**
	 * 가상머신 네트워크 인터페이스 목록 조회
	 * 
	 * @param vmNetworkVO 검색 조건
	 * @return
	 */
	@Override
	public List<VMNetworkVO> selectVMNetworkList(VMNetworkVO vmNetworkVO) {
		return vmDAO.selectVMNetworkList(vmNetworkVO);
	}
	
	/**
	 * 가상머신 CD-ROM 목록 조회
	 * 
	 * @param vmCDROMVO 검색 조건
	 * @return
	 */
	@Override
	public List<VMCDROMVO> selectVMCDROMList(VMCDROMVO vmCDROMVO) {
		return vmDAO.selectVMCDROMList(vmCDROMVO);
	}
	
	/**
	 * 가상머신의 서비스ID 수정
	 * 
	 * @param vmID 가상머신 ID
	 * @param vmServiceID
	 * @return
	 */
	@Transactional
	public void updateVmDataServiceId(String vmID, Integer vmServiceID) {
		VMDataVO vmDataVO = new VMDataVO();
		vmDataVO.setVmServiceID(vmServiceID);
		vmDataVO.setVmID(vmID);
		vmDAO.updateVmDataServiceId(vmDataVO);
	}
	
	/**
	 * 가상머신 목록의 서비스ID 수정
	 * 
	 * @param vmIDList 가상머신 ID 목록
	 * @param vmServiceID
	 * @return
	 */
	@Override
	@Transactional
	public void updateVmDataServiceId(String[] vmIDList, Integer vmServiceID) {
		VMDataVO vmDataVO = new VMDataVO();
		vmDataVO.setVmServiceID(vmServiceID);
		for(String vmID : vmIDList) {
			vmDataVO.setVmID(vmID);
			vmDAO.updateVmDataServiceId(vmDataVO);
		}
	}
	
	/**
	 * 가상머신 템플릿 수정
	 * 
	 * @param vmDataVO
	 * @return
	 */
	@Override
	@Transactional
	public int updateVMTemplate(VMDataVO vmDataVO) {
		return vmDAO.updateVMTemplate(vmDataVO);
	}
	
	/**
	 * 가상머신 CD-ROM 등록
	 * 
	 * @param vmCDROMVO
	 * @return
	 */
	@Override
	@Transactional
	public int insertVMCDROM(VMCDROMVO vmCDROMVO) {
		int count = vmDAO.countVMCDROM(vmCDROMVO);
		vmCDROMVO.setnSCSInumber(count + 1);
		return vmDAO.insertVMCDROM(vmCDROMVO);
	}
	
	/**
	 * 가상머신 CD-ROM 삭제
	 * 
	 * @param sVmID
	 * @return
	 */
	@Override
	@Transactional
	public int deleteVMCDROM(String sVmID) {
		return vmDAO.deleteVMCDROM(sVmID);
	}
	
	/**
	 * DHCP 값에 따른 가상머신 게이트웨이, 아이피 설정
	 * 
	 * @param tenantVO
	 * @param serviceVO
	 * @param vmCreateVO
	 * @return
	 */
	@Override
	public VMCreateVO setGatewayAndNetmaskByDHCP(TenantVO tenantVO, 
			VMServiceVO serviceVO, VMCreateVO vmCreateVO) {

		// DHCP 사용여부가 OFF인 경우
		if (vmCreateVO.getCrDhcp() == 2) {
			
			if (vmCreateVO.getDhcpCategory() == 1) {
				// DHCP 카테고리가 테넌트인 경우
				vmCreateVO.setCrGateway(tenantVO.getDefaultGateway());
				vmCreateVO.setCrNetmask(tenantVO.getDefaultNetmask());
				
			} else if (vmCreateVO.getDhcpCategory() == 2) {
				// DHCP 카테고리가 서비스인 경우
				vmCreateVO.setCrGateway(serviceVO.getDefaultGateway());
				vmCreateVO.setCrNetmask(serviceVO.getDefaultNetmask());
				
			}
		}
		return vmCreateVO;
	}
	
	/**
	 * 로그인 사용자 승인(권한)에 따른 승인 단계 얻기
	 * 
	 * @return
	 */
	@Override
	public int getStage() {
		
		UserVO loginInfo = LoginSessionUtil.getLoginInfo();
		int approval = loginInfo.getnApproval();
		
		int stage = 0;
		if (approval == Constants.USER_NUMBER) {
			stage = 1;
		} else if (approval == Constants.TENANT_ADMIN_NUMBER) {
			stage = 5;
		} else if (approval == Constants.SUPER_ADMIN_NUMBER) {
			stage = 5;
		}
		return stage;
	}
	
	/**
	 * 사용자 승인(권한)에 따른 승인 단계 얻기
	 * 
	 * @param nApproval
	 * @return
	 */
	@Override
	public int getStage(int approval) {
		int stage = 0;
		if (approval == Constants.USER_NUMBER) {
			stage = 1;
		} else if (approval == Constants.TENANT_ADMIN_NUMBER) {
			stage = 5;
		} else if (approval == Constants.SUPER_ADMIN_NUMBER) {
			stage = 5;
		}
		return stage;
	}

	@Override
	public List<VMDataVO> selectPNIC(String cluster, String host) {
		return vmDAO.selectPNIC(cluster,host);
		
	}


}
