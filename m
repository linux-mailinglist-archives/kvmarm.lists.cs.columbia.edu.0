Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6724B27E2A3
	for <lists+kvmarm@lfdr.de>; Wed, 30 Sep 2020 09:31:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DA8104B3CA;
	Wed, 30 Sep 2020 03:31:28 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, body has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YkcqJptJyPWT; Wed, 30 Sep 2020 03:31:28 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 947714B3A2;
	Wed, 30 Sep 2020 03:31:27 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CAC944B374
 for <kvmarm@lists.cs.columbia.edu>; Wed, 30 Sep 2020 03:31:26 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 23ZeVu8gMsxe for <kvmarm@lists.cs.columbia.edu>;
 Wed, 30 Sep 2020 03:31:25 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id BCD274B351
 for <kvmarm@lists.cs.columbia.edu>; Wed, 30 Sep 2020 03:31:25 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8C01F2075F;
 Wed, 30 Sep 2020 07:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601451084;
 bh=zKXXC8/eaM3s9VAg1agAJZNl1O3BJbovoo1wj+XC2gs=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=xlsJGEQb79c9JCXTbMX3cv7MY1oVemijSDXY2K0N12n027Unawd7yaVjgPmeMOigi
 1/LCVlNsx96XLI71ifNUZ4dVkbbSHvq3d00tTLA5KETp0mCRbUHuQBbRkr/HKb1I+p
 X2W3vpC4L3zi3LZ26aolqfeDMkvJipHyXubSJiJI=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=hot-poop.lan) by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1kNWa9-00G6Aw-S7; Wed, 30 Sep 2020 08:31:22 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
 Alexandru Elisei <alexandru.elisei@arm.com>, kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH v2 0/2] KVM: arm64: Documentation updates
Date: Wed, 30 Sep 2020 08:31:17 +0100
Message-Id: <160145106760.805503.16221753406075770666.b4-ty@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200924123731.268177-1-alexandru.elisei@arm.com>
References: <20200924123731.268177-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org,
 alexandru.elisei@arm.com, kvmarm@lists.cs.columbia.edu
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
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

On Thu, 24 Sep 2020 13:37:29 +0100, Alexandru Elisei wrote:
> I noticed some discrepancies between the error codes returned by KVM PMU
> emulation and the documentation, this is my attempt at fixing them.
> 
> The code is from the original implementation of KVM PMU, and I thought it
> would be more prudent to modify the documentation to match the code instead
> of the other way around.
> 
> [...]

Applied to next, thanks!

[1/2] KVM: arm64: Add undocumented return values for PMU device control group
      commit: af130d0adc8e48c73030c0d71a59ce1f7809a8fa
[2/2] KVM: arm64: Match PMU error code descriptions with error conditions
      commit: 51dd2eb98c72c1ff4cdb1526fff9a259a563c257

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
