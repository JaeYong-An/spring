console.log(`i'm here`);

document.getElementById(`cmtPostBtn`).addEventListener(`click`, ()=>{
    const cmtText = document.getElementById(`cmtText`);
    if(cmtText.value == null || cmtText.value ==``){
        alert(`댓글을 입력하세요`);
        cmtText.focus();
        return false;
    }else{
        let cmtData={
            bno:bnoVal,
            writer:document.getElementById(`cmtWriter`).value,
            content:cmtText.innerText
        };
        console.log(cmtData);
        postCommentToServer(cmtData).then(result =>{
            if(result==`1`){
                alert(`댓글 등록 성공`);
                cmtText.innerText=``;
            }
            //화면에 뿌리기
        })
    }

})

async function postCommentToServer(cmtData){
    try {
        const url = `/comment/post`;
        const config ={
            method:`post`,
            headers:{
                'content-type':`application/json; charset=utf-8`
            },
            body:JSON.stringify(cmtData)
        };
        const resp = await fetch(url, config);
        const result = await resp.text();
        return result;
    } catch (error) {
        console.log(error);
    }
}