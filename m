Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 42D6C5E11D
	for <lists+kvmarm@lfdr.de>; Wed,  3 Jul 2019 11:35:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 84ECC4A4E9;
	Wed,  3 Jul 2019 05:35:44 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W3D0b6ShdVMz; Wed,  3 Jul 2019 05:35:44 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 583794A4E1;
	Wed,  3 Jul 2019 05:35:43 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5FC914A479
 for <kvmarm@lists.cs.columbia.edu>; Wed,  3 Jul 2019 05:35:42 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wiiITv83Uze5 for <kvmarm@lists.cs.columbia.edu>;
 Wed,  3 Jul 2019 05:35:41 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 187F940A52
 for <kvmarm@lists.cs.columbia.edu>; Wed,  3 Jul 2019 05:35:41 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CB23344;
 Wed,  3 Jul 2019 02:35:40 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 488063F246;
 Wed,  3 Jul 2019 02:35:39 -0700 (PDT)
Date: Wed, 3 Jul 2019 10:35:37 +0100
From: Will Deacon <will.deacon@arm.com>
To: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH kvmtool v4 0/8] arm64: Pointer Authentication and SVE
 support
Message-ID: <20190703093537.GC3122@fuggles.cambridge.arm.com>
References: <1559906789-20936-1-git-send-email-Dave.Martin@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1559906789-20936-1-git-send-email-Dave.Martin@arm.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Cc: Christoffer Dall <cdall@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Kristina Martsenko <kristina.martsenko@arm.com>,
 Zhang Lei <zhang.lei@jp.fujitsu.com>,
 Amit Daniel Kachhap <amit.kachhap@arm.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
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

On Fri, Jun 07, 2019 at 12:26:21PM +0100, Dave Martin wrote:
> This series, based on kvmtool master [1], implements basic support for
> pointer authentication and SVE for guests.  This superseded the
> previous v3 series [2].

I'd prefer to use the release headers for 5.2, so I've taken the first three
patches for now, but I'll wait for you to repost once 5.2 is out before I
take the rest.

Thanks,

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
