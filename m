Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BBA9A5EBFC3
	for <lists+kvmarm@lfdr.de>; Tue, 27 Sep 2022 12:30:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DEA524B6E2;
	Tue, 27 Sep 2022 06:30:22 -0400 (EDT)
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
	with ESMTP id VJYB-hfDjzkO; Tue, 27 Sep 2022 06:30:22 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 89D344B64C;
	Tue, 27 Sep 2022 06:30:21 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 850A44B62D
 for <kvmarm@lists.cs.columbia.edu>; Tue, 27 Sep 2022 06:30:20 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Uv+kc9y4QTBL for <kvmarm@lists.cs.columbia.edu>;
 Tue, 27 Sep 2022 06:30:19 -0400 (EDT)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 322084B600
 for <kvmarm@lists.cs.columbia.edu>; Tue, 27 Sep 2022 06:30:19 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id C69F661786;
 Tue, 27 Sep 2022 10:30:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B80AC433C1;
 Tue, 27 Sep 2022 10:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1664274617;
 bh=noLfpBznClPHMdqAPG/zfUiiDoQtXSGh5jj+GB+3a2A=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=kP/zIhDCpN9GeuCa86YPBy6ZUyvmmh0KwWwhSanPXaMnbbovb9bcWur8Vx1b0vHLr
 NLrtqGlymkT+SyT19palenEEtIlkWoZnhGYkPxInVwIHI28TuqtM7uA6/5abnAsz8d
 FUylvbaKA/D87LsBVCQZTbbfANi10YlVGtY+rERgQK++bd6LLOSc7v4A1bZOI3gqOJ
 q9gDFJ9I3IFMY7TO0tbP3vEtT1Cq+zEbymAs54gaXBx4fExwNe1xmec5IfC0WAicDj
 aEqEMKLCrgg/KC5crU0a+CnmOvF/70RqHfXpEQE/9+qkiKA3M4Vit/NjFWKVmtqG3X
 90IpeKWNK6Gwg==
Received: from sofa.misterjones.org ([185.219.108.64]
 helo=goblin-girl.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <maz@kernel.org>) id 1od7qw-00CwrO-Hq;
 Tue, 27 Sep 2022 11:30:14 +0100
Date: Tue, 27 Sep 2022 06:30:14 -0400
Message-ID: <86wn9p6rex.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v4 0/6] KVM: arm64: Enable ring-based dirty memory tracking
In-Reply-To: <20220927005439.21130-1-gshan@redhat.com>
References: <20220927005439.21130-1-gshan@redhat.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: gshan@redhat.com, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org, catalin.marinas@arm.com, bgardon@google.com,
 shuah@kernel.org, andrew.jones@linux.dev, will@kernel.org, dmatlack@google.com,
 peterx@redhat.com, pbonzini@redhat.com, zhenyzha@redhat.com,
 shan.gavin@gmail.com, james.morse@arm.com, suzuki.poulose@arm.com,
 alexandru.elisei@arm.com, oliver.upton@linux.dev, seanjc@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, catalin.marinas@arm.com, andrew.jones@linux.dev,
 will@kernel.org, shan.gavin@gmail.com, bgardon@google.com, dmatlack@google.com,
 pbonzini@redhat.com, zhenyzha@redhat.com, shuah@kernel.org,
 kvmarm@lists.cs.columbia.edu
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

+ Sean

On Mon, 26 Sep 2022 20:54:33 -0400,
Gavin Shan <gshan@redhat.com> wrote:
> 
> This series enables the ring-based dirty memory tracking for ARM64.
> The feature has been available and enabled on x86 for a while. It
> is beneficial when the number of dirty pages is small in a checkpointing
> system or live migration scenario. More details can be found from
> fb04a1eddb1a ("KVM: X86: Implement ring-based dirty memory tracking").
> 
> This series is applied on top of Marc's v2 series [0], fixing dirty-ring
> ordering issue.

This looks good to me as it stands. If someone on the x86 side of
things is willing to ack the x86 changes (both here and in my
series[0]), I'm happy to queue the whole thing.

Thanks,

	M.

[0] https://lore.kernel.org/kvmarm/20220926145120.27974-1-maz@kernel.org

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
