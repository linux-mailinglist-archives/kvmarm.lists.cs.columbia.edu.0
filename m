Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D9FB61BF484
	for <lists+kvmarm@lfdr.de>; Thu, 30 Apr 2020 11:50:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6CB144B517;
	Thu, 30 Apr 2020 05:50:51 -0400 (EDT)
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
	with ESMTP id wUV8FsTTXYYZ; Thu, 30 Apr 2020 05:50:51 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 54F854B519;
	Thu, 30 Apr 2020 05:50:50 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CDB1F4B513
 for <kvmarm@lists.cs.columbia.edu>; Thu, 30 Apr 2020 05:50:48 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xa8ENI7Ezi8V for <kvmarm@lists.cs.columbia.edu>;
 Thu, 30 Apr 2020 05:50:47 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id E2A834B514
 for <kvmarm@lists.cs.columbia.edu>; Thu, 30 Apr 2020 05:50:46 -0400 (EDT)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2E8842082E;
 Thu, 30 Apr 2020 09:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588240245;
 bh=2m/uMwubJU0+KIoLz1IiF/eJGyPbsWV2OVU8vrOQqBo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=2NRs0g5xV7M8d3FZI52+oAVxuGVFjMu5w2Mtg08swn4HAuP9oO90gxHDaPWncU2UL
 LHZJg7J1RhAMhIQhXIHKyOLmHY9dQlwhRuRCVLx4RQskm5Pe4dqAJsLx2cEZ4Q1UHw
 DI8NdPhL4/nhgDpGR/qDoTIRy7rNQwpQDiXhw35A=
Date: Thu, 30 Apr 2020 10:50:37 +0100
From: Will Deacon <will@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] arm64: kvm: fix gcc-10 shift warning
Message-ID: <20200430095037.GA19932@willie-the-truck>
References: <20200429185657.4085975-1-arnd@arndb.de>
 <20200430090251.715f6bf0@why>
 <20200430082927.GA18615@willie-the-truck>
 <20200430193910.294842c4@canb.auug.org.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200430193910.294842c4@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Rich Felker <dalias@libc.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Catalin Marinas <catalin.marinas@arm.com>, Paul Mackerras <paulus@samba.org>,
 kvmarm@lists.cs.columbia.edu, Jonas Bonn <jonas@southpole.se>,
 Brian Cain <bcain@codeaurora.org>, Marc Zyngier <maz@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Ley Foon Tan <ley.foon.tan@intel.com>,
 Mike Rapoport <rppt@linux.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Fenghua Yu <fenghua.yu@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>,
 linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <christophe.leroy@c-s.fr>, Tony Luck <tony.luck@intel.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-kernel@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>
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

On Thu, Apr 30, 2020 at 07:39:10PM +1000, Stephen Rothwell wrote:
> On Thu, 30 Apr 2020 09:29:28 +0100 Will Deacon <will@kernel.org> wrote:
> > On Thu, Apr 30, 2020 at 09:02:51AM +0100, Marc Zyngier wrote:
> > > On Wed, 29 Apr 2020 20:56:20 +0200
> > > Arnd Bergmann <arnd@arndb.de> wrote:
> > >   
> > > > Fixes: 22998131ab33 ("arm64: add support for folded p4d page tables")
> > 
> > Happy to queue via arm64 for 5.8. Does that work for you, Arnd, or were you
> > planning to get this in sooner than that?
> 
> The commit that this fixes is in Andrew's patch series in linux-next,
> so it should just go in there.

Yes, you're right. Sorry for the noise.

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
