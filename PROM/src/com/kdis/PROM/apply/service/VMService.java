package com.kdis.PROM.apply.service;

import java.util.List;

import com.kdis.PROM.apply.vo.ApprovalWorkflowVO;
import com.kdis.PROM.apply.vo.VMCDROMVO;
import com.kdis.PROM.apply.vo.VMCreateVO;
import com.kdis.PROM.apply.vo.VMDataVO;
import com.kdis.PROM.apply.vo.VMDiskVO;
import com.kdis.PROM.apply.vo.VMNetworkVO;
import com.kdis.PROM.tenant.vo.TenantVO;
import com.kdis.PROM.tenant.vo.VMServiceVO;

/**
 * 가상머신 서비스 interface
 * 
 * @author KimHahn
 *
 */
public interface VMService {
	
	public void updateVmDataComment(VMDataVO dbVMData);
	
	
	
	/**
	 * 가상머신 목록 조회
	 * 
	 * @param vmDataVO
	 * @return
	 */
	public List<VMDataVO> selectVMDataList(VMDataVO vmDataVO);
	
	/**
	 * 사용자가 속한 가상머신 목록 조회
	 * 
	 * @param vmDataVO
	 * @return
	 */
	public List<VMDataVO> selectVMDataListByUserMapping(VMDataVO vmDataVO);

	/**
	 * 서비스에 배치된 가상머신 목록 조회
	 * 
	 * @return
	 */
	public List<VMDataVO> selectArrangedVMList();
	
	/**
	 * 서비스에 배치 안된 가상머신 목록 조회
	 * 
	 * @return
	 */
	public List<VMDataVO> selectUnarrangedVMList();
	
	/**
	 * 가상머신 템플릿 목록 조회
	 * 
	 * @return
	 */
	public List<VMDataVO> selectVMTemplateList();
	
	/**
	 * ON인 가상머신 템플릿 목록 조회
	 * 
	 * @param searchParam 검색어
	 * @param sort 정렬:AES, DESC
	 * @return
	 */
	public List<VMDataVO> selectVMTemplateOnList(String searchParam, String sort);
	
	/**
	 * 가상머신 조회
	 * 
	 * @param vmID 가상머신 아이디
	 * @return
	 */
	public VMDataVO selectVMData(String vmID);
	
	/**
	 * 가상머신명으로 가상머신 조회
	 * 
	 * @param vmName 가상머신명
	 * @return
	 */
	public VMDataVO selectVMDataByVMName(String vmName);
	
	/**
	 * 가상머신 생성 신청 목록 조회
	 * 
	 * @param vmCreateVO 검색 조건
	 * @return
	 */
	public List<VMCreateVO> selectApplyVMList(VMCreateVO vmCreateVO);
	
	/**
	 * 사용자와 매핑된 서비스 그룹의 가상머신 생성 신청 목록 조회
	 * 
	 * @param vmCreateVO 검색 조건
	 * @return
	 */
	public List<VMCreateVO> selectApplyVMListByUserMapping(VMCreateVO vmCreateVO);
	
	/**
	 * 가상머신 승인 Workflow 목록 조회
	 * 
	 * @param crNum 가상머신 생성 ID
	 * @param stage 단계
	 * @return
	 */
	public List<ApprovalWorkflowVO> selectApprovalWorkflowList(Integer crNum, Integer stage);
	
	/**
	 * 가상머신 생성 정보 조회
	 * 	crSorting == 1 : 가상머신 템플릿 정보 추가
	 * 	crSorting == 2 : 가상머신 정보 추가
	 * 
	 * @param vmCreateVO 검색 조건
	 * @return
	 */
	public VMCreateVO selectVMCreate(VMCreateVO vmCreateVO);
	
	/**
	 * 가상머신 반환 신청 개수 조회
	 * 
	 * @param vmName 가상머신명
	 * @return
	 */
	public int countVMReturn(String vmName);
	
	/**
	 * 가상머신 생성 등록
	 * 
	 * @param vmCreateVO
	 * @return
	 */
	public int insertVMCreate(VMCreateVO vmCreateVO);
	
	/**
	 * 가상머신 생성 승인 단계 수정
	 * 
	 * @param crNum
	 * @param crApproval
	 * @return
	 */
	public int updateVMCreateApproval(Integer crNum, Integer crApproval);
	
	/**
	 * 가상머신 생성 승인 단계 수정
	 * 
	 * @param crNum
	 * @param crApproval
	 * @param crIPAddress
	 * @return
	 */
	public int updateVMCreateApproval(Integer crNum, Integer crApproval, String crIPAddress);
	
	/**
	 * 가상머신 생성/변경 보류
	 * 
	 * @param crNum
	 * @param crComment
	 * @return
	 */
	public int holdVMCreate(Integer crNum, String crComment);
	
	/**
	 * 가상머신 생성/변경/반환 반려
	 * 
	 * @param crNum
	 * @param crComment
	 * @return
	 */
	public int rejectVMCreate(Integer crNum, String crComment);
	
	/**
	 * 가상머신 승인 Workflow 등록
	 * 
	 * @param approvalWorkflowVO
	 * @return
	 */
	public int insertApprovalWorkflow(ApprovalWorkflowVO approvalWorkflowVO);
	
	/**
	 * 가상머신 승인 Workflow 수정
	 * 
	 * @param approvalWorkflowVO
	 * @return
	 */
	public int updateApprovalWorkflow(ApprovalWorkflowVO approvalWorkflowVO);
	
	/**
	 * 가상머신 생성 정보로 가상머신 승인 Workflow 등록
	 * 
	 * @param vmCreateVO
	 */
	public void insertApprovalWorkflow(VMCreateVO vmCreateVO);
	
	/**
	 * 가상머신 Disk 목록 조회
	 * 
	 * @param vmDiskVO 검색 조건
	 * @return
	 */
	public List<VMDiskVO> selectVMDiskList(VMDiskVO vmDiskVO);
	
	/**
	 * 가상머신 네트워크 인터페이스 목록 조회
	 * 
	 * @param vmNetworkVO 검색 조건
	 * @return
	 */
	public List<VMNetworkVO> selectVMNetworkList(VMNetworkVO vmNetworkVO);
	
	/**
	 * 가상머신 CD-ROM 목록 조회
	 * 
	 * @param vmCDROMVO 검색 조건
	 * @return
	 */
	public List<VMCDROMVO> selectVMCDROMList(VMCDROMVO vmCDROMVO);
	
	/**
	 * 가상머신의 서비스ID 수정
	 * 
	 * @param vmID 가상머신 ID
	 * @param vmServiceID
	 * @return
	 */
	public void updateVmDataServiceId(String vmID, Integer vmServiceID);
	
	/**
	 * 가상머신 목록의 서비스ID 수정
	 * 
	 * @param vmIDList 가상머신 ID 목록
	 * @param vmServiceID
	 * @return
	 */
	public void updateVmDataServiceId(String[] vmIDList, Integer vmServiceID);
	
	/**
	 * 가상머신 템플릿 수정
	 * 
	 * @param vmDataVO
	 * @return
	 */
	public int updateVMTemplate(VMDataVO vmDataVO);
	
	/**
	 * 가상머신 CD-ROM 등록
	 * 
	 * @param vmCDROMVO
	 * @return
	 */
	public int insertVMCDROM(VMCDROMVO vmCDROMVO);
	
	/**
	 * 가상머신 CD-ROM 삭제
	 * 
	 * @param sVmID
	 * @return
	 */
	public int deleteVMCDROM(String sVmID);
	
	/**
	 * DHCP 값에 따른 가상머신 게이트웨이, 아이피 설정
	 * 
	 * @param tenantVO
	 * @param serviceVO
	 * @param vmCreateVO
	 * @return
	 */
	public VMCreateVO setGatewayAndNetmaskByDHCP(TenantVO tenantVO, 
			VMServiceVO serviceVO, VMCreateVO vmCreateVO);
	
	/**
	 * 로그인 사용자 승인(권한)에 따른 승인 단계 얻기
	 * 
	 * @return
	 */
	public int getStage();
	
	/**
	 * 사용자 승인(권한)에 따른 승인 단계 얻기
	 * 
	 * @param nApproval
	 * @return
	 */
	public int getStage(int approval);

	public List<VMDataVO> selectPNIC(String cluster, String host);
	
}
