Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9C24E3B22
	for <lists+kvmarm@lfdr.de>; Tue, 22 Mar 2022 09:48:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A18E849E2A;
	Tue, 22 Mar 2022 04:48:30 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.788
X-Spam-Level: 
X-Spam-Status: No, score=-1.788 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, RCVD_IN_DNSWL_BLOCKED=0.001, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BLmef0Lu2Zk9; Tue, 22 Mar 2022 04:48:30 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 641D740B03;
	Tue, 22 Mar 2022 04:48:29 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C13E740177
 for <kvmarm@lists.cs.columbia.edu>; Tue, 22 Mar 2022 04:48:27 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ULsZSurHmKZk for <kvmarm@lists.cs.columbia.edu>;
 Tue, 22 Mar 2022 04:48:26 -0400 (EDT)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 81BDB40BD3
 for <kvmarm@lists.cs.columbia.edu>; Tue, 22 Mar 2022 04:48:26 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 53CDB615E3;
 Tue, 22 Mar 2022 08:48:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD3E6C340EC;
 Tue, 22 Mar 2022 08:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1647938904;
 bh=Uds2yt6H1y65fhPnvGjWXdpR5/JP7jfcOFrj7qPJFcI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=H8N/fMRWalNI5m8S8DWvtFYQR414v1HclflHQBJ2eZ7Owv67YZpxoLOpksAW4cqQj
 xWyd4yVE8YVuf8wMafMuz0Bfbj1WVkIpYe3Zq1DEH/xnW07Yb0l7aKluRRubYMb6tW
 UCM4J27TlZgN0JX83SM9aFgbMGjNpcZStR2zDEjdCAI79NcET5Sr75x4OReCgZmD/7
 qGq2z6udGF3HrDz2iLPavDUtzmQx75NCjxC1b0psRA9q0ne+suVtVYmEyyTo96aqqv
 PahlcJVVcFY7cHLSrKhSYCFH+g2M43vxkCPsTkgnm96r3ihGz2wuyB6T076vgWCM82
 pQQbtEEyGwWjg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1nWaBi-00GDUi-3I; Tue, 22 Mar 2022 08:48:22 +0000
Date: Tue, 22 Mar 2022 08:48:21 +0000
Message-ID: <87cziextii.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Oliver Upton <oupton@google.com>
Subject: Re: [PATCH 2/2] KVM: arm64: Actually prevent SMC64 SYSTEM_RESET2 from
 AArch32
In-Reply-To: <YjljaS3Jeste4/ID@google.com>
References: <20220318193831.482349-1-oupton@google.com>
 <20220318193831.482349-3-oupton@google.com>
 <CAAeT=FwR-=U_0WvKqV4UTCmo8x1=atBVtTQeirwiF3XCo+S=1g@mail.gmail.com>
 <YjljaS3Jeste4/ID@google.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: oupton@google.com, reijiw@google.com,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, james.morse@arm.com,
 alexandru.elisei@arm.com, suzuki.poulose@arm.com,
 linux-arm-kernel@lists.infradead.org, pshier@google.com, ricarkol@google.com,
 pbonzini@redhat.com, will@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, Will Deacon <will@kernel.org>,
 Peter Shier <pshier@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 kvmarm@lists.cs.columbia.edu, Linux ARM <linux-arm-kernel@lists.infradead.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On Tue, 22 Mar 2022 05:49:29 +0000,
Oliver Upton <oupton@google.com> wrote:
> 
> On Mon, Mar 21, 2022 at 09:41:39PM -0700, Reiji Watanabe wrote:
> > On 3/18/22 12:38 PM, Oliver Upton wrote:
> > > The SMCCC does not allow the SMC64 calling convention to be used from
> > > AArch32. While KVM checks to see if the calling convention is allowed in
> > > PSCI_1_0_FN_PSCI_FEATURES, it does not actually prevent calls to
> > > unadvertised PSCI v1.0+ functions.
> > >
> > > Check to see if the requested function is allowed from the guest's
> > > execution state. Deny the call if it is not.
> > >
> > > Fixes: d43583b890e7 ("KVM: arm64: Expose PSCI SYSTEM_RESET2 call to the guest")
> > > Cc: Will Deacon <will@kernel.org>
> > > Signed-off-by: Oliver Upton <oupton@google.com>
> > 
> > Reviewed-by: Reiji Watanabe <reijiw@google.com>
> 
> Appreciated :-)
> 
> > BTW, considering the new kvm_psci_check_allowed_function()implementation
> > in the patch-1, it might be better to call kvm_psci_check_allowed_function()
> > from kvm_psci_call() instead?  Then, we could avoid the similar issue
> > next time we support a newer PSCI version.
> 
> Good point. If Marc doesn't bite in the next day or two I'll address
> this with a new spin, otherwise I'll do a separate cleanup. Just want to
> avoid spamming on this topic since I already replied with yet another
> patch [1].

Please do, and I'll queue that for -rc1.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
