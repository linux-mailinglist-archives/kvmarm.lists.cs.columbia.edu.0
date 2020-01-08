Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 84F1B134435
	for <lists+kvmarm@lfdr.de>; Wed,  8 Jan 2020 14:45:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 226F84AFB1;
	Wed,  8 Jan 2020 08:45:32 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UHxEoDT8WnCv; Wed,  8 Jan 2020 08:45:32 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 199214B023;
	Wed,  8 Jan 2020 08:45:31 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E2D064AFB3
 for <kvmarm@lists.cs.columbia.edu>; Wed,  8 Jan 2020 08:45:29 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cKcr8yPebZgZ for <kvmarm@lists.cs.columbia.edu>;
 Wed,  8 Jan 2020 08:45:28 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 89CE04AFB1
 for <kvmarm@lists.cs.columbia.edu>; Wed,  8 Jan 2020 08:45:28 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DB2431B;
 Wed,  8 Jan 2020 05:45:28 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B79F73F703;
 Wed,  8 Jan 2020 05:45:26 -0800 (PST)
Date: Wed, 8 Jan 2020 13:45:24 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 maz@kernel.org, alexandru.elisei@arm.com
Subject: Re: [PATCHv2 0/3] KVM: arm/arm64: exception injection fixes
Message-ID: <20200108134524.GE49203@lakrids.cambridge.arm.com>
References: <20200108134324.46500-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200108134324.46500-1-mark.rutland@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Cc: stable@vger.kernel.org, will@kernel.org
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

On Wed, Jan 08, 2020 at 01:43:21PM +0000, Mark Rutland wrote:
> Since v1 [2]:
> * Fix host_spsr_to_spsr32() bit preservation
> * Fix SPAN polarity; tested with a modified arm64 guest
> * Fix DIT preservation on 32-bit hosts
> * Add Alex's Reviewed-by to patch 3
> 
> Thanks,
> Mark.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=kvm/exception-state

Whoops; I missed the list reference for v1:

[2] https://lore.kernel.org/r/20191220150549.31948-1-mark.rutland@arm.com

Mark.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
