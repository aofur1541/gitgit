package com.kdis.PROM.apply.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kdis.PROM.apply.vo.ApprovalWorkflowVO;
import com.kdis.PROM.apply.vo.VMCDROMVO;
import com.kdis.PROM.apply.vo.VMCreateVO;
import com.kdis.PROM.apply.vo.VMDataVO;
import com.kdis.PROM.apply.vo.VMDiskVO;
import com.kdis.PROM.apply.vo.VMNetworkVO;

/**
 * 가상머신 DAO interface
 * 
 * @author KimHahn
 *
 */
public interface VMDAO {

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
	 * @param vmDataVO 검색 조건
	 * @return
	 */
	public List<VMDataVO> selectVMTemplateOnList(VMDataVO vmDataVO);
	
	/**
	 * 가상머신 조회
	 * 
	 * @param vmID 가상머신 아이디
	 * @return
	 */
	public VMDataVO selectVMData(VMDataVO vmDataVO);
	
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
	 * @param approvalWorkflowVO
	 * @return
	 */
	public List<ApprovalWorkflowVO> selectApprovalWorkflowList(ApprovalWorkflowVO approvalWorkflowVO);
	
	/**
	 * 가상머신 생성 조회
	 * 
	 * @param vmCreateVO 검색 조건
	 * @return
	 */
	public VMCreateVO selectVMCreate(VMCreateVO vmCreateVO);
	
	/**
	 * 가상머신 반환 신청 개수 조회
	 * 
	 * @param vmCreateVO 검색 조건
	 * @return
	 */
	public int countVMReturn(VMCreateVO vmCreateVO);
	
	/**
	 * 가상머신 생성 등록
	 * 
	 * @param vmCreateVO 검색 조건
	 * @return
	 */
	public int insertVMCreate(VMCreateVO vmCreateVO);

	/**
	 * 가상머신 생성 승인 단계 수정
	 * 
	 * @param vmCreateVO
	 * @return
	 */
	public int updateVMCreateApproval(VMCreateVO vmCreateVO);
	
	/**
	 * 가상머신 생성/변경 보류
	 * 
	 * @param vmCreateVO
	 * @return
	 */
	public int holdVMCreate(VMCreateVO vmCreateVO);
	
	/**
	 * 가상머신 생성/변경/반환 반려
	 * 
	 * @param vmCreateVO
	 * @return
	 */
	public int rejectVMCreate(VMCreateVO vmCreateVO);
	
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
	 * 가상머신 CD-ROM 목록 갯수 조회
	 * 
	 * @param vmCDROMVO 검색 조건
	 * @return
	 */
	public int countVMCDROM(VMCDROMVO vmCDROMVO);
	
	/**
	 * 가상머신의 서비스ID 수정
	 * 
	 * @param vmDataVO
	 * @return
	 */
	public int updateVmDataServiceId(VMDataVO vmDataVO);
	
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

	public List<VMDataVO> selectPNIC(@Param("cluster") String cluster,@Param("host") String host);


}
