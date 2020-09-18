$(function(){
if(sessionApproval < ADMINCHECK){
alert("올바르지 않은 경로 진입");
window.parent.location.href = '/menu/userDashboard.do';
}
});