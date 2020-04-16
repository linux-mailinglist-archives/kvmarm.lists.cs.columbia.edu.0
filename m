Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA8E1AD724
	for <lists+kvmarm@lfdr.de>; Fri, 17 Apr 2020 09:13:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F0EA44B26C;
	Fri, 17 Apr 2020 03:13:15 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 5.677
X-Spam-Level: *****
X-Spam-Status: No, score=5.677 required=6.1 tests=[BAYES_20=-0.001,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_SORBS_WEB=0.77,
	SPF_HELO_PASS=-0.001, TO_MALFORMED=2.099, TVD_SPACE_RATIO=0.001,
	T_DKIM_INVALID=0.01] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, body has been altered) header.i=@novsu.ru
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZzUWftojAjwc; Fri, 17 Apr 2020 03:13:15 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 03DD34B1FE;
	Fri, 17 Apr 2020 03:13:12 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 650F04B239
 for <kvmarm@lists.cs.columbia.edu>; Thu, 16 Apr 2020 16:50:46 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id adQmY7VlgqJR for <kvmarm@lists.cs.columbia.edu>;
 Thu, 16 Apr 2020 16:50:45 -0400 (EDT)
Received: from xcp137.novsu.ac.ru (xcp137.novsu.ac.ru [80.250.189.11])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 0C64A4B235
 for <kvmarm@lists.cs.columbia.edu>; Thu, 16 Apr 2020 16:50:45 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by xcp137.novsu.ac.ru (Postfix) with ESMTP id C669D61D47;
 Thu, 16 Apr 2020 23:50:40 +0300 (MSK)
Received: from xcp137.novsu.ac.ru ([127.0.0.1])
 by localhost (xcp137.novsu.ac.ru [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id Y5Ehw9BdEt2T; Thu, 16 Apr 2020 23:50:40 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
 by xcp137.novsu.ac.ru (Postfix) with ESMTP id 448ED61D66;
 Thu, 16 Apr 2020 23:50:39 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 xcp137.novsu.ac.ru 448ED61D66
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=novsu.ru;
 s=AB32354C-6D0E-11E7-857E-252FEF7F1304; t=1587070240;
 bh=+slkbZJPWM2ceFoh17//Eu44P/KZJq9EqQOtvHwqE9Y=;
 h=MIME-Version:To:From:Date:Message-Id;
 b=XSAjP3tZ6zxrM67mnpZjBVjECylrz+JUgKN1QBW0l7JUEToJeeNxHH4CjAujaXdj2
 kbi3IvERm4mf5nldfTs12Oyu0TktJxtVDmSfG3Y1GQuvBMVL2FwNEOHmQD2yv54/WA
 0kNVOswmqfRhL5Z/f5GKOcgWORC2Tkqu6mZqetgs=
X-Virus-Scanned: amavisd-new at xcp137.novsu.ac.ru
Received: from xcp137.novsu.ac.ru ([127.0.0.1])
 by localhost (xcp137.novsu.ac.ru [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 3LlP-Kciy98J; Thu, 16 Apr 2020 23:50:39 +0300 (MSK)
Received: from [192.168.8.100] (unknown [197.211.61.56])
 by xcp137.novsu.ac.ru (Postfix) with ESMTPSA id CBDCD61D47;
 Thu, 16 Apr 2020 23:50:36 +0300 (MSK)
MIME-Version: 1.0
Content-Description: Mail message body
Subject: ***SPAM*** Vorschlag
To: Recipients <>
From: Yi Huiman <""@novsu.ru>
Date: Thu, 16 Apr 2020 21:50:35 +0100
Message-Id: <20200416205036.CBDCD61D47@xcp137.novsu.ac.ru>
X-Mailman-Approved-At: Fri, 17 Apr 2020 03:13:10 -0400
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
Reply-To: info@huiman.cf
List-Id: Where KVM/ARM decisions are made <kvmarm.lists.cs.columbia.edu>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

I have a proposal for you.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
