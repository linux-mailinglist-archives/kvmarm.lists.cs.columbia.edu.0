Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4313D29F6A4
	for <lists+kvmarm@lfdr.de>; Thu, 29 Oct 2020 22:09:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D54BB4B689;
	Thu, 29 Oct 2020 17:09:32 -0400 (EDT)
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
	with ESMTP id gOmIjfKUXlu8; Thu, 29 Oct 2020 17:09:31 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2C8E14B67B;
	Thu, 29 Oct 2020 17:09:31 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 689B74B4A4
 for <kvmarm@lists.cs.columbia.edu>; Thu, 29 Oct 2020 17:09:29 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lo0X0bO1RZk7 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 29 Oct 2020 17:09:28 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 51F514B66B
 for <kvmarm@lists.cs.columbia.edu>; Thu, 29 Oct 2020 17:09:28 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CFCE420791;
 Thu, 29 Oct 2020 21:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604005767;
 bh=bNbPFZ+4DbPibhlFNfuibwuRNeDZSwZ0ygc8fqBSEso=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=p+kQZbYrYBtdwLNzDpLO4xgvoAw33UrM4AZ9Vm3XFrSUqiLsAZz6hSVqxwuqjaGQS
 rkJOWxbt6QipcUUYHIwQz7DFD+WKQP52hhvc6QIWijpQqAGUmzSDT4VqdQ/vKuxN+V
 gkgw64VolyF/d5oAd3iurvvf3VsSAzdRSL2hAdyM=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=wait-a-minute.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1kYFAi-005YNy-Gh; Thu, 29 Oct 2020 21:09:24 +0000
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.cs.columbia.edu,
	Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v2] KVM: arm64: Failback on unsupported huge page sizes
Date: Thu, 29 Oct 2020 21:09:15 +0000
Message-Id: <160400571841.9348.15515000266981677007.b4-ty@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201025230626.18501-1-gshan@redhat.com>
References: <20201025230626.18501-1-gshan@redhat.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, gshan@redhat.com,
 shan.gavin@gmail.com, will@kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: will@kernel.org, linux-kernel@vger.kernel.org, shan.gavin@gmail.com
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

On Mon, 26 Oct 2020 10:06:26 +1100, Gavin Shan wrote:
> The huge page could be mapped through multiple contiguous PMDs or PTEs.
> The corresponding huge page sizes aren't supported by the page table
> walker currently.
> 
> This fails the unsupported huge page sizes to the near one. Otherwise,
> the guest can't boot successfully: CONT_PMD_SHIFT and CONT_PTE_SHIFT
> fail back to PMD_SHIFT and PAGE_SHIFT separately.

Applied to next, thanks!

[1/1] KVM: arm64: Use fallback mapping sizes for contiguous huge page sizes
      commit: 2f40c46021bbb3ecd5c5f05764ecccbc276bc690

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
