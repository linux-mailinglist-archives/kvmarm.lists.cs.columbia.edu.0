Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 954A51E1AC1
	for <lists+kvmarm@lfdr.de>; Tue, 26 May 2020 07:44:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B7D244B235;
	Tue, 26 May 2020 01:44:43 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.908
X-Spam-Level: 
X-Spam-Status: No, score=0.908 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, SPF_HELO_PASS=-0.001,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@ozlabs.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6AvYneI0wdz4; Tue, 26 May 2020 01:44:43 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 87C854B223;
	Tue, 26 May 2020 01:44:42 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8B0D84B145
 for <kvmarm@lists.cs.columbia.edu>; Tue, 26 May 2020 01:44:41 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ymcGNjxXo9uu for <kvmarm@lists.cs.columbia.edu>;
 Tue, 26 May 2020 01:44:40 -0400 (EDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 134894B11C
 for <kvmarm@lists.cs.columbia.edu>; Tue, 26 May 2020 01:44:40 -0400 (EDT)
Received: by ozlabs.org (Postfix, from userid 1003)
 id 49WNFb23Kfz9sRY; Tue, 26 May 2020 15:44:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1590471875; bh=j0PNgC0xr6mRDHCZ2htDfbQsT0XH5gFzuCdilAoQCBw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=H05nUKbvRSIH+7O5N9VUsnkHeRklB48VujBczf2Xtd7k/msK8glVNwOfwKFhBxaM2
 RMEhFP3061zuW6+4Tyn4tcDNAEbnpgE5y/GbpnLgkqD9inO7dRTJ8JdJazRZlG5By1
 dDTw25f7q0+rjMvV86X6zTMCLnL9GISRBtWJGAOBofFztGdhMaHaSDnzVJeKDOeTRr
 P/gT1fm1rSHSwWvDzu+Yy/x7JV3Y4U7YJfxqHFYoVKLC8zIAnftSk9Bv7oB4+ke1/z
 t+6gHdzDMsO3E/gW5yqaeDf4mGpMKKUTqOEkTCh4o4CEB+cdOrXQUL3itzvvSsvIix
 ogkCA1YC4CmqQ==
Date: Tue, 26 May 2020 14:36:56 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: Re: [PATCH v4 3/7] KVM: PPC: Remove redundant kvm_run from vcpu_arch
Message-ID: <20200526043656.GA282305@thinks.paulus.ozlabs.org>
References: <20200427043514.16144-1-tianjia.zhang@linux.alibaba.com>
 <20200427043514.16144-4-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200427043514.16144-4-tianjia.zhang@linux.alibaba.com>
Cc: wanpengli@tencent.com, kvm@vger.kernel.org, david@redhat.com,
 benh@kernel.crashing.org, heiko.carstens@de.ibm.com,
 linux-mips@vger.kernel.org, hpa@zytor.com, kvmarm@lists.cs.columbia.edu,
 linux-s390@vger.kernel.org, frankja@linux.ibm.com, chenhuacai@gmail.com,
 maz@kernel.org, joro@8bytes.org, x86@kernel.org, borntraeger@de.ibm.com,
 mingo@redhat.com, thuth@redhat.com, gor@linux.ibm.com, kvm-ppc@vger.kernel.org,
 bp@alien8.de, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
 jmattson@google.com, tsbogend@alpha.franken.de, cohuck@redhat.com,
 sean.j.christopherson@intel.com, linux-kernel@vger.kernel.org,
 mpe@ellerman.id.au, pbonzini@redhat.com, vkuznets@redhat.com,
 linuxppc-dev@lists.ozlabs.org
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

On Mon, Apr 27, 2020 at 12:35:10PM +0800, Tianjia Zhang wrote:
> The 'kvm_run' field already exists in the 'vcpu' structure, which
> is the same structure as the 'kvm_run' in the 'vcpu_arch' and
> should be deleted.
> 
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>

This looks fine.

I assume each architecture sub-maintainer is taking the relevant
patches from this series via their tree - is that right?

Reviewed-by: Paul Mackerras <paulus@ozlabs.org>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
