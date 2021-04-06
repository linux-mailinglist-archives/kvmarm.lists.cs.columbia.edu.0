Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C77F13554DD
	for <lists+kvmarm@lfdr.de>; Tue,  6 Apr 2021 15:21:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 667064B9D8;
	Tue,  6 Apr 2021 09:21:04 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Wnkag-rDwVQ3; Tue,  6 Apr 2021 09:21:04 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 582864BA39;
	Tue,  6 Apr 2021 09:21:03 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1DF514B9D8
 for <kvmarm@lists.cs.columbia.edu>; Tue,  6 Apr 2021 09:21:01 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9x21RgTfzgZS for <kvmarm@lists.cs.columbia.edu>;
 Tue,  6 Apr 2021 09:21:00 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 2803A4B84D
 for <kvmarm@lists.cs.columbia.edu>; Tue,  6 Apr 2021 09:21:00 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 19159613B7;
 Tue,  6 Apr 2021 13:20:59 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1lTldY-005riK-1V; Tue, 06 Apr 2021 14:20:56 +0100
From: Marc Zyngier <maz@kernel.org>
To: alexandru.elisei@arm.com, will@kernel.org,
 Wang Wensheng <wangwensheng4@huawei.com>,
 linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com,
 dbrazdil@google.com, linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
 james.morse@arm.com, kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH -next] KVM: arm64: Fix error return code in init_hyp_mode()
Date: Tue,  6 Apr 2021 14:20:48 +0100
Message-Id: <161771524130.1078033.5622332810036336940.b4-ty@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210406121759.5407-1-wangwensheng4@huawei.com>
References: <20210406121759.5407-1-wangwensheng4@huawei.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: alexandru.elisei@arm.com, will@kernel.org,
 wangwensheng4@huawei.com, linux-arm-kernel@lists.infradead.org,
 suzuki.poulose@arm.com, dbrazdil@google.com, linux-kernel@vger.kernel.org,
 catalin.marinas@arm.com, james.morse@arm.com, kvmarm@lists.cs.columbia.edu,
 rui.xiang@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: rui.xiang@huawei.com
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

On Tue, 6 Apr 2021 12:17:59 +0000, Wang Wensheng wrote:
> Fix to return a negative error code from the error handling
> case instead of 0, as done elsewhere in this function.

Applied to kvm-arm64/misc-5.13, thanks!

[1/1] KVM: arm64: Fix error return code in init_hyp_mode()
      commit: 52b9e265d22bccc5843e167da76ab119874e2883

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
