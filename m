Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id CDAE2113D7E
	for <lists+kvmarm@lfdr.de>; Thu,  5 Dec 2019 10:02:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4BBF04AEC5;
	Thu,  5 Dec 2019 04:02:42 -0500 (EST)
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
	with ESMTP id OdfvkFaUDzc4; Thu,  5 Dec 2019 04:02:42 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2482A4AEA0;
	Thu,  5 Dec 2019 04:02:41 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 844604AE8D
 for <kvmarm@lists.cs.columbia.edu>; Thu,  5 Dec 2019 04:02:39 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SOxrmZRnqdgg for <kvmarm@lists.cs.columbia.edu>;
 Thu,  5 Dec 2019 04:02:38 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 87CBE4A982
 for <kvmarm@lists.cs.columbia.edu>; Thu,  5 Dec 2019 04:02:38 -0500 (EST)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EA035205ED;
 Thu,  5 Dec 2019 09:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1575536557;
 bh=IegRoMB/1Q1fRaPPqw8Gvk6tJnrbo+VYNJkThGWkX78=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hOAWg22NhSCrXMFC8ojXb8dJREu5nEV6aGcQg8f1YrwCh1LW7FM3d72d7RZ+mZHZa
 /4soWC1ihRSIBsdfmQkz3s0YiLdUpgVzWWRHGdAhRWlyOK4GBRB0jKRiW6Pm6gRBq0
 ZKiONXU6Fa+5gEsiYN/wqU8x/gAphf4z8YQjo2fc=
Date: Thu, 5 Dec 2019 09:02:32 +0000
From: Will Deacon <will@kernel.org>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [RFC 3/3] KVM: arm64: pmu: Enforce PMEVTYPER evtCount size
Message-ID: <20191205090232.GC8606@willie-the-truck>
References: <20191204204426.9628-1-eric.auger@redhat.com>
 <20191204204426.9628-4-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191204204426.9628-4-eric.auger@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: maz@kernel.org, linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
 eric.auger.pro@gmail.com
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

On Wed, Dec 04, 2019 at 09:44:26PM +0100, Eric Auger wrote:
> ARMv8.1-PMU supports 16-bit evtCount whereas 8.0 only supports
> 10 bits.
> 
> On Seatlle which has an 8.0 PMU implementation, evtCount[15:10]
> are not read as 0, as expected. Fix that by applying a mask on
> the selected event that depends on the PMU version.

Are you sure about that? These bits are RES0 in 8.0 afaict, so this would be
a CPU erratum. Have you checked the SDEN document (I haven't)?

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
