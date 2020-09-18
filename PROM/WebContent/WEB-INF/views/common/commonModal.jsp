<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div id="changeVMResource" class="modal fade" tabindex="-1">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header bg-prom" id="changeVM-modal-header"></div>
			<div class="modal-body bg-light modal-type-1 modal-type-1-2">
				<div class="card mb-0">
					<div class="card-header bg-white">
						<a href="#change-input" data-toggle="collapse">
							<span class="h6 card-title"><i class="icon-checkbox-unchecked2 text-prom mr-2"></i>변경 정보</span>
							<i class="icon-arrow-down12 text-prom"></i>
						</a>
					</div>
					<div id="change-input" class="collapse show">
						<div class="card-body bg-light">
							<div class="row">
								<div class="col-sm-12 col-xl-12">
									<div class="form-group">
										<label>가상머신명:</label>
										<input type="text" class="form-control form-control-modal" id="choicevmName" disabled>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-sm-6 col-xl-6">
									<div class="form-group">
										<label>vCPU:</label>
										<input type="text" class="form-control form-control-modal" placeholder="vCPU" min="1" max="32" id="vCPUchangeValueIT">
									</div>
								</div>
								<div class="col-sm-6 col-xl-6">
									<div class="form-group">
										<label>Memory:</label>
										<input type="text" class="form-control form-control-modal" placeholder="memory" min="1" max="32" id="memorychangeValueIT">
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-sm-12 col-xl-12">
									<div class="form-group">
										<label>신청 사유:</label>
										<textarea class="form-control form-control-modal" placeholder="comment for applying" autocomplete="off" maxlength="80" id="reasonForApply"></textarea>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="card mb-0">
					<div class="card-header bg-white">
						<a href="#change-warning-info" data-toggle="collapse">
							<span class="h6 card-title"><i class="icon-warning22 text-prom mr-2"></i>주의 사항</span>
							<i class="icon-arrow-down12 text-prom"></i>
						</a>
					</div>
					<div id="change-warning-info" class="collapse show">
						<div class="card-body bg-light">
							<p>
								1. 핫플러그가 OFF인 경우, 가상머신이 재시작 됩니다.<br>
								<span class="text-prom ml-2">* </span>현재 CPU 핫플러그: <span class="text-prom" id="choicevCPUhotAdd"></span>, Memory 핫플러그: <span class="text-prom" id="choiceMemoryhotAdd"></span>
							</p>
							<p>
								2. 활성 메모리 크기보다 작게 축소할 수 없습니다.
							</p>
							<p>
								3. 핫 플러그 활성화 가상머신의 메모리가 3 GB 이하일 경우 자원 변경 기능이 작동하지 않습니다.
							</p>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer bg-white" id="changeVM-modal-footer"></div>
		</div>
	</div>
</div>