Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 12D0D4741E1
	for <lists+kvmarm@lfdr.de>; Tue, 14 Dec 2021 12:57:06 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 873E14B1F3;
	Tue, 14 Dec 2021 06:57:05 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, T_DKIM_INVALID=0.01]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7bxpok-3sG7y; Tue, 14 Dec 2021 06:57:05 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4565E4B1B4;
	Tue, 14 Dec 2021 06:57:04 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5F1B14B12E
 for <kvmarm@lists.cs.columbia.edu>; Tue, 14 Dec 2021 06:57:03 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4JiRQ8zqGxaj for <kvmarm@lists.cs.columbia.edu>;
 Tue, 14 Dec 2021 06:57:02 -0500 (EST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 613B44B116
 for <kvmarm@lists.cs.columbia.edu>; Tue, 14 Dec 2021 06:57:02 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 3BF56614A1;
 Tue, 14 Dec 2021 11:57:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A41EAC34601;
 Tue, 14 Dec 2021 11:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1639483020;
 bh=FAheOAFVBOjbmeJ7xmDDDgpCkGhFGIolFk++QjIuXr8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=cpJUazKFcOPowGzUzudZZczu2nt8pB6Wb1aWPK4EIsqlb3T37LIQ5xD99xqod1olO
 sM+mED4FuNob6zZ3juRRsA6HHntiBXuxB/Uegkx23N4KCCPAQlGVgc/iGJnw5W30bF
 ho+XHKHnRYvqQEBcmCDZnVKdLFZjMJqPeXMip5BGNC3+lBcM0mRmlCeMxJK8uHLELI
 lSTtDD2f5svTQC2EeZ/I+1PJT21YVsx8QVrF/D09G0JqTwuv/l8omtSirzvaRB29/M
 M1Qdc0e0jRFpL/iLmlaQTzLDRNFE68rcYpWnqiLHzy7kqNITKFl9eoMF4cTrw1SkOc
 NT5vq9eJJvzPg==
Received: from cfbb000407.r.cam.camfibre.uk ([185.219.108.64]
 helo=why.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1mx6QU-00C2AI-BO; Tue, 14 Dec 2021 11:56:58 +0000
Date: Tue, 14 Dec 2021 11:56:57 +0000
Message-ID: <874k7bjt6e.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Reiji Watanabe <reijiw@google.com>
Subject: Re: [PATCH v2 0/4] KVM: arm64: Improve PMU support on heterogeneous
 systems
In-Reply-To: <CAAeT=FxK2F+GUdJ_0z6rb4F5ttjW5ZyD7Sa_eyiaKc=xxDdMkg@mail.gmail.com>
References: <20211206170223.309789-1-alexandru.elisei@arm.com>
 <CAAeT=FygprcS3YxbVaW+4yUjHBm8=MxZ+j4_iVjq7ie-ppRKRg@mail.gmail.com>
 <addac215bddf0b86bf6850093d500785@kernel.org>
 <CAAeT=Fzz2UGQAWGx_4piJGng5BKpX3FQrZDA7u2PHFcTRD4G4w@mail.gmail.com>
 <YbcrKAE35GMzPQBt@monolith.localdoman>
 <CAAeT=FxK2F+GUdJ_0z6rb4F5ttjW5ZyD7Sa_eyiaKc=xxDdMkg@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: reijiw@google.com, alexandru.elisei@arm.com,
 james.morse@arm.com, suzuki.poulose@arm.com, will@kernel.org,
 mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, tglx@linutronix.de, mingo@redhat.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: will@kernel.org, mingo@redhat.com, tglx@linutronix.de,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

On Tue, 14 Dec 2021 06:24:38 +0000,
Reiji Watanabe <reijiw@google.com> wrote:
> 
> Hi Alex,
> 
> On Mon, Dec 13, 2021 at 3:14 AM Alexandru Elisei
> <alexandru.elisei@arm.com> wrote:
> >
> > Also, as VCPUs get migrated from one physical CPU to the other, the
> > semantics of the microarchitectural events change, even if the event ID is
> > the same.
> 
> Yes, I understand.  As mentioned, this can work only when the
> CPU affinity is set for vCPU threads appropriately (, which could
> be done even without changing userspace).

Implicit bindings to random PMUs based on the scheduling seems a
pretty fragile API to me, and presents no real incentive for userspace
to start doing the right thing.

I'd prefer not counting events at all when on the wrong CPU (for some
definition of 'wrong'), rather than accumulating unrelated events.
Both are admittedly wrong, but between two evils, I'd rather stick
with the one I know (and that doesn't require any change)...

Alex's series brings a way to solve this by allowing userspace to pick
a PMU and make sure userspace is aware of the consequences. It puts
userspace in charge, and doesn't leave space for ambiguous behaviours.

I definitely find value in this approach.

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
