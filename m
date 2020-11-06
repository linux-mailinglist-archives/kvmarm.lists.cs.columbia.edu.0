Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 98FC92A9987
	for <lists+kvmarm@lfdr.de>; Fri,  6 Nov 2020 17:35:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 483944B8A4;
	Fri,  6 Nov 2020 11:35:36 -0500 (EST)
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
	with ESMTP id N16xhhQUtPlq; Fri,  6 Nov 2020 11:35:35 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 537014B8AA;
	Fri,  6 Nov 2020 11:35:34 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 118464B7EF
 for <kvmarm@lists.cs.columbia.edu>; Fri,  6 Nov 2020 11:35:33 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pl5CyuP1mzxG for <kvmarm@lists.cs.columbia.edu>;
 Fri,  6 Nov 2020 11:35:32 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 163804B7AF
 for <kvmarm@lists.cs.columbia.edu>; Fri,  6 Nov 2020 11:35:32 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CB7B521556;
 Fri,  6 Nov 2020 16:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604680531;
 bh=0wCWpAcIHmBZ8yj4LMDQrJn2YVM8psFMGCTOMTg3pjw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CwTM2TDFzuMMUG4CzOaHC4OMdPkhbVE+ZqHMLqy1BQTXaKgbRmUy31T5q9Syd6zzv
 xaSx4JeZeXJ7aLtou2VJGGBLXUO+afxrfSvCy0itTcBajVK4K9OO7dhaLRE43vGY8N
 EriscBXfkyPlcsDw6uY8lI9Y5ff0eXp98BfH+D18=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=wait-a-minute.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1kb4i1-008FRC-01; Fri, 06 Nov 2020 16:35:29 +0000
From: Marc Zyngier <maz@kernel.org>
To: Andrew Jones <drjones@redhat.com>, kvmarm@lists.cs.columbia.edu,
 Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH] KVM: arm64: Fix build error in user_mem_abort()
Date: Fri,  6 Nov 2020 16:35:20 +0000
Message-Id: <160468048426.137782.4397939179876151819.b4-ty@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103003009.32955-1-gshan@redhat.com>
References: <20201103003009.32955-1-gshan@redhat.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: drjones@redhat.com, kvmarm@lists.cs.columbia.edu,
 gshan@redhat.com, xu910121@sina.com, Dave.Martin@arm.com, will@kernel.org,
 shan.gavin@gmail.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: will@kernel.org, xu910121@sina.com, Dave.Martin@arm.com,
 shan.gavin@gmail.com, linux-kernel@vger.kernel.org
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

On Tue, 3 Nov 2020 11:30:09 +1100, Gavin Shan wrote:
> The PUD and PMD are folded into PGD when the following options are
> enabled. In that case, PUD_SHIFT is equal to PMD_SHIFT and we fail
> to build with the indicated errors:
> 
>    CONFIG_ARM64_VA_BITS_42=y
>    CONFIG_ARM64_PAGE_SHIFT=16
>    CONFIG_PGTABLE_LEVELS=3
> 
> [...]

Applied to next, thanks!

[1/1] KVM: arm64: Fix build error in user_mem_abort()
      commit: faf000397e7f103df9953a312e1df21df1dc797f

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
