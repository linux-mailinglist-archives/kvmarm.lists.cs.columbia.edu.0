Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id EED6425F9C6
	for <lists+kvmarm@lfdr.de>; Mon,  7 Sep 2020 13:46:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 79A864B5E9;
	Mon,  7 Sep 2020 07:46:58 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8K9JmL-M5DnH; Mon,  7 Sep 2020 07:46:58 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 252394B5CF;
	Mon,  7 Sep 2020 07:46:57 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C061E4B594
 for <kvmarm@lists.cs.columbia.edu>; Mon,  7 Sep 2020 07:46:55 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F+wA3IK7Hiis for <kvmarm@lists.cs.columbia.edu>;
 Mon,  7 Sep 2020 07:46:55 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id DF4274B510
 for <kvmarm@lists.cs.columbia.edu>; Mon,  7 Sep 2020 07:46:54 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A9B83207C3;
 Mon,  7 Sep 2020 11:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599479213;
 bh=vQO/mkxuUbHFYS++GetY/5IbiGpHZq/A237zPcJhwgM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=fNDGu7mTBtk8PQxAIPQHwhjGaVbFXr9qH6cLFvurGeCbDr6ln7HI8DW/B9ikeWC3d
 bbrDDN5x05NX2U8o6egXGMq6NsghFnV6h8Is3xvWG28nMunPLzR/HDAkI4uIgQcYwX
 XlCTE4KPsi1fCkRHTWm7xKx8kVX8ZN7FUepOIAfA=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=wait-a-minute.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1kFFbn-009kme-Lk; Mon, 07 Sep 2020 12:46:51 +0100
Date: Mon, 07 Sep 2020 12:46:50 +0100
Message-ID: <87wo15lsgl.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Andrew Scull <ascull@google.com>
Subject: Re: [PATCH v3 07/18] KVM: arm64: nVHE: Don't consume host SErrors
 with ESB
In-Reply-To: <20200903135307.251331-8-ascull@google.com>
References: <20200903135307.251331-1-ascull@google.com>
 <20200903135307.251331-8-ascull@google.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL/10.8 EasyPG/1.0.0 Emacs/26.3
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: ascull@google.com, kvmarm@lists.cs.columbia.edu,
 james.morse@arm.com, suzuki.poulose@arm.com, julien.thierry.kdev@gmail.com,
 will@kernel.org, catalin.marinas@arm.com, kernel-team@android.com,
 sudeep.holla@arm.com, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, catalin.marinas@arm.com,
 linux-arm-kernel@lists.infradead.org, Sudeep Holla <sudeep.holla@arm.com>,
 will@kernel.org, kvmarm@lists.cs.columbia.edu
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

On Thu, 03 Sep 2020 14:52:56 +0100,
Andrew Scull <ascull@google.com> wrote:
> 
> The ESB at the start of the host vector may cause SErrors to be consumed
> to DISR_EL1. However, this is not checked for the host so the SError
> could go unhandled.
> 
> Remove the ESB so that SErrors are not consumed but are instead left
> pending for the host to consume. __guest_enter already defers entry into
> a guest if there are any SErrors pending.
> 
> Fixes: 0e5b9c085dce ("KVM: arm64: Consume pending SError as early as possible")

I'd drop the Fixes: tag here. The KVM RAS support was never designed
to use nVHE the first place, and this patch is impossible to backport
without dragging tons of other patches, turning it into a nightmare.

The patch itself is fine.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
