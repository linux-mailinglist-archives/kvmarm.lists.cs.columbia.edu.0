Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 739B019F70C
	for <lists+kvmarm@lfdr.de>; Mon,  6 Apr 2020 15:35:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E29244B199;
	Mon,  6 Apr 2020 09:35:43 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.392
X-Spam-Level: 
X-Spam-Status: No, score=-1.392 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@xen.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5ev8tWdtWoDJ; Mon,  6 Apr 2020 09:35:43 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AB3604B17E;
	Mon,  6 Apr 2020 09:35:42 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 62E884B16C
 for <kvmarm@lists.cs.columbia.edu>; Mon,  6 Apr 2020 09:16:49 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EKNCtcJ04WX8 for <kvmarm@lists.cs.columbia.edu>;
 Mon,  6 Apr 2020 09:16:47 -0400 (EDT)
Received: from mail.xenproject.org (mail.xenproject.org [104.130.215.37])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 82B884B16B
 for <kvmarm@lists.cs.columbia.edu>; Mon,  6 Apr 2020 09:16:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xen.org;
 s=20200302mail; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
 Message-ID:Cc:To:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9miVRYCMvr1Uvww2T7Kj3Ck9eMJTDfng4CaO3elt314=; b=53xUmM5P65NYBcJdrA40VgMU7X
 rBRfkE16e3+PIttsoxK+Dn99gYVB2V+nCJoHEXDTxUbiOKDkTkQbTc22uf0SwxrNXhSbzsiC6BUPN
 Wxu7L8DgZ3g18ADrVUzgAKzVXDx6IGWqtU5RMWSrU6vuUH672pf3NzA1brdaHxnvfWOI=;
Received: from xenbits.xenproject.org ([104.239.192.120])
 by mail.xenproject.org with esmtp (Exim 4.89)
 (envelope-from <julien@xen.org>)
 id 1jLRcI-00025f-2L; Mon, 06 Apr 2020 13:16:42 +0000
Received: from 54-240-197-239.amazon.com ([54.240.197.239]
 helo=a483e7b01a66.ant.amazon.com)
 by xenbits.xenproject.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <julien@xen.org>)
 id 1jLRcH-0004fB-RA; Mon, 06 Apr 2020 13:16:41 +0000
From: Julien Grall <julien@xen.org>
Subject: I{S,C}ACTIVER implemention question
To: Marc Zyngier <maz@kernel.org>, james.morse@arm.com,
 julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com
Message-ID: <c90bdfa0-00cf-170b-4319-e270e8aaef7e@xen.org>
Date: Mon, 6 Apr 2020 14:16:39 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Language: en-GB
X-Mailman-Approved-At: Mon, 06 Apr 2020 09:35:41 -0400
Cc: "George.Dunlap@eu.citrix.com" <George.Dunlap@eu.citrix.com>,
 Stefano Stabellini <sstabellini@kernel.org>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org,
 Bertrand Marquis <Bertrand.Marquis@arm.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

Hi,

Xen community is currently reviewing a new implementation for reading 
I{S,C}ACTIVER registers (see [1]).

The implementation is based on vgic_mmio_read_active() in KVM, i.e the 
active state of the interrupts is based on the vGIC state stored in memory.

While reviewing the patch on xen-devel, I noticed a potential deadlock 
at least with Xen implementation. I know that Xen vGIC and KVM vGIC are 
quite different, so I looked at the implementation to see how this is dealt.

With my limited knowledge of KVM, I wasn't able to rule it out. I am 
curious to know if I missed anything.

vCPU A may read the active state of an interrupt routed to vCPU B. When 
vCPU A is reading the state, it will read the state stored in memory.

The only way the memory state can get synced with the HW state is when 
vCPU B exit guest context.

AFAICT, vCPU B will not exit when deactivating HW mapped interrupts and 
virtual edge interrupts. So vCPU B may run for an abritrary long time 
before been exiting and syncing the memory state with the HW state.

Looking at Linux (5.4 and onwards) use of the active state, vCPU A would 
loop until the interrupt is not active anymore. So wouldn't the task on 
vCPU A be blocked for an arbitrary long time?

Cheers,

[1] 
https://lists.xenproject.org/archives/html/xen-devel/2020-03/msg01844.html

-- 
Julien Grall
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
