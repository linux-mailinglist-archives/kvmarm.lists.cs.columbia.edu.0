Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 27E7B18A779
	for <lists+kvmarm@lfdr.de>; Wed, 18 Mar 2020 22:58:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8A90A4B09B;
	Wed, 18 Mar 2020 17:58:57 -0400 (EDT)
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
	with ESMTP id SYMnhtH2iMVM; Wed, 18 Mar 2020 17:58:57 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5F3744B089;
	Wed, 18 Mar 2020 17:58:56 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 711A44A4FC
 for <kvmarm@lists.cs.columbia.edu>; Wed, 18 Mar 2020 17:58:54 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KgM4H9igsahd for <kvmarm@lists.cs.columbia.edu>;
 Wed, 18 Mar 2020 17:58:53 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 68C724A4CD
 for <kvmarm@lists.cs.columbia.edu>; Wed, 18 Mar 2020 17:58:53 -0400 (EDT)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EADC32076C;
 Wed, 18 Mar 2020 21:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1584568732;
 bh=fwb6/1fl+qNWmdBmMiFQ8pSoakKvLGgyes9mRnF7u2c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iXspVkpnNVO09YFjhzaEWdYDvt1usZAPfrJ2RQL2f3zpxwByHpOjc+QPpyTTvVNJk
 fRhTMX4fIg5OHKVaB9/BPg0aRQySOWuEoOw7OAhLKWd5kSRxpBkRoywrWBYZu7OK+B
 PAINfI9FfrQ0FVsS9z4hGvsl96KHzUXa3BOIlzVk=
Date: Wed, 18 Mar 2020 21:58:47 +0000
From: Will Deacon <will@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH kvmtool v3] Add emulation for CFI compatible flash memory
Message-ID: <20200318215847.GC8477@willie-the-truck>
References: <20200221165532.90618-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200221165532.90618-1-andre.przywara@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kvm@vger.kernel.org, Raphael Gault <raphael.gault@arm.com>,
 Sami Mujawar <sami.mujawar@arm.com>, kvmarm@lists.cs.columbia.edu,
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

On Fri, Feb 21, 2020 at 04:55:32PM +0000, Andre Przywara wrote:
> From: Raphael Gault <raphael.gault@arm.com>
> 
> The EDK II UEFI firmware implementation requires some storage for the EFI
> variables, which is typically some flash storage.
> Since this is already supported on the EDK II side, we add a CFI flash
> emulation to kvmtool.
> This is backed by a file, specified via the --flash or -F command line
> option. Any flash writes done by the guest will immediately be reflected
> into this file (kvmtool mmap's the file).
> The flash will be limited to the nearest power-of-2 size, so only the
> first 2 MB of a 3 MB file will be used.
> 
> This implements a CFI flash using the "Intel/Sharp extended command
> set", as specified in:
> - JEDEC JESD68.01
> - JEDEC JEP137B
> - Intel Application Note 646
> Some gaps in those specs have been filled by looking at real devices and
> other implementations (QEMU, Linux kernel driver).
> 
> At the moment this relies on DT to advertise the base address of the
> flash memory (mapped into the MMIO address space) and is only enabled
> for ARM/ARM64. The emulation itself is architecture agnostic, though.
> 
> This is one missing piece toward a working UEFI boot with kvmtool on
> ARM guests, the other is to provide writable PCI BARs, which is WIP.
> 
> Signed-off-by: Raphael Gault <raphael.gault@arm.com>
> [Andre: rewriting and fixing]
> Signed-off-by: Andre Przywra <andre.przywara@arm.com>
> ---
> Hi,
> 
> an update fixing Alexandru's review comments (many thanks for those!)
> The biggest change code-wise is the split of the MMIO handler into three
> different functions. Another significant change is the rounding *down* of
> the present flash file size to the nearest power-of-two, to match flash
> hardware chips and Linux' expectations.

Alexandru -- are you happy with this now?

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
