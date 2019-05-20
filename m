Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 27D6222E5F
	for <lists+kvmarm@lfdr.de>; Mon, 20 May 2019 10:22:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 68DD04A530;
	Mon, 20 May 2019 04:22:58 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 4.426
X-Spam-Level: ****
X-Spam-Status: No, score=4.426 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, HTML_IMAGE_ONLY_12=2.059,
	HTML_MESSAGE=0.001, INVALID_MSGID=0.568, RCVD_IN_DNSWL_NONE=-0.0001,
	SPF_HELO_PASS=-0.001, TO_NO_BRKTS_HTML_IMG=1] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vj9mRKLhzZsm; Mon, 20 May 2019 04:22:58 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 94E584A511;
	Mon, 20 May 2019 04:22:53 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5DB744A4A3
 for <kvmarm@lists.cs.columbia.edu>; Sun, 19 May 2019 23:20:14 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ukuQRNsPeWMR for <kvmarm@lists.cs.columbia.edu>;
 Sun, 19 May 2019 23:20:07 -0400 (EDT)
Received: from smtpbgsg3.qq.com (smtpbgsg3.qq.com [54.179.177.220])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 2CD184A479
 for <kvmarm@lists.cs.columbia.edu>; Sun, 19 May 2019 23:20:06 -0400 (EDT)
X-QQ-mid: bizesmtp15t1558322391tnpdmonk
Received: from [10.11.32.138] (unknown [39.155.168.46])
 by esmtp4.qq.com (ESMTP) with 
 id ; Mon, 20 May 2019 11:19:50 +0800 (CST)
X-QQ-SSF: 01400000000000B0C424B00A0000000
X-QQ-FEAT: 5p2KJntE3DGNDrU81d3ZhYoACbIf+1XUCBy7pRf0vH7KWBikkVv/RVdYynIwa
 8bGL9slLkbUDzPfuRoVJplFqLXIIaKoizaJX0XFPMDSh9QzR68dUBsw76km/DssAbnxOCfm
 A8WrgrzQshAUXgj+eC/oltCjdRviVPOHtzTbM2iTx8bgrKYs4prNzCHwtLut7DjRqbYenuq
 tFnoJuLBOabnldISHCj1U7B1AKGWwN1sXjUViPmcgEDRnv845olWUWwHF/v17ckQe50hgaM
 fEdRZJokGIjPWGeYv2sNn2aJR5qv0pLWt+HNrm/kQwU7YhIJvcHlPYdOH+CNtmt32lc+ghu
 /TqsL5DloBUOnaFL/7fO1OG+FXCUw==
X-QQ-GoodBg: 2
To: kvmarm@lists.cs.columbia.edu
From: kevin zhao <xiaoqiang.zhao@cloudminds.com>
Subject: ARM64 kvm cache coherency problem
Message-ID: <7c31d3ab-ac30-626e-05be-b2547b558f4a@cloudminds.com>+45FD319A4707829E
Date: Mon, 20 May 2019 11:19:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------AFC39BD304A214EF0198DF06"
Content-Language: en-US
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cloudminds.com:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
X-Mailman-Approved-At: Mon, 20 May 2019 04:22:52 -0400
Cc: marc.zyngier@arm.com
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
List-Id: Where KVM/ARM decisions are made <kvmarm.lists.cs.columbia.edu>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

This is a multi-part message in MIME format.
--------------AFC39BD304A214EF0198DF06
Content-Type: multipart/alternative;
 boundary="------------63A2E3EA8506D96BCE10B39B"


--------------63A2E3EA8506D96BCE10B39B
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

  Hi, there:

     I have seen some RFC about solving ARM64 kvm cache incoherency 
issue ([1], [2]) in May 2015. I followed a few threads and did not

know how this arguments ends.

    Does anybody know how this problem  is solved finally ?

    Thank you guys!


[1] https://lists.cs.columbia.edu/pipermail/kvmarm/2015-May/014567.html

[2] https://lists.cs.columbia.edu/pipermail/kvmarm/2015-May/014643.html

-- 

--------------63A2E3EA8506D96BCE10B39B
Content-Type: multipart/related;
 boundary="------------D962B4434E572C9EF6C67634"


--------------D962B4434E572C9EF6C67634
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
     Hi, there:
    <p>    I have seen some RFC about solving ARM64 kvm cache
      incoherency issue ([1], [2]) in May 2015. I followed a few threads
      and did not <br>
    </p>
    <p>know how this arguments ends.<br>
    </p>
    <p>   Does anybody know how this problem  is solved finally ? <br>
    </p>
    <p>   Thank you guys!<br>
    </p>
    <p><br>
    </p>
    <p>[1] <a
href="https://lists.cs.columbia.edu/pipermail/kvmarm/2015-May/014567.html">https://lists.cs.columbia.edu/pipermail/kvmarm/2015-May/014567.html</a></p>
    <p>[2] <a moz-do-not-send="true"
href="https://lists.cs.columbia.edu/pipermail/kvmarm/2015-May/014643.html">https://lists.cs.columbia.edu/pipermail/kvmarm/2015-May/014643.html</a><br>
    </p>
    <div class="moz-signature">-- <br>
      <img src="cid:part3.6A245A6E.1D9312E2@cloudminds.com" border="0"></div>
  </body>
</html>

--------------D962B4434E572C9EF6C67634
Content-Type: image/png;
 name="CloudMinds Logo_English_Color_Landscape_forEmail116.png"
Content-Transfer-Encoding: base64
Content-ID: <part3.6A245A6E.1D9312E2@cloudminds.com>
Content-Disposition: inline;
 filename="CloudMinds Logo_English_Color_Landscape_forEmail116.png"

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
RU5ErkJggg==
--------------D962B4434E572C9EF6C67634--

--------------63A2E3EA8506D96BCE10B39B--

--------------AFC39BD304A214EF0198DF06
Content-Type: text/x-vcard; charset=utf-8;
 name="xiaoqiang_zhao.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="xiaoqiang_zhao.vcf"

begin:vcard
fn;quoted-printable:=E8=B5=B5 =E5=B0=8F=E5=BC=BA
n;quoted-printable;quoted-printable:=E5=B0=8F=E5=BC=BA;=E8=B5=B5
version:2.1
end:vcard


--------------AFC39BD304A214EF0198DF06
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm

--------------AFC39BD304A214EF0198DF06--


