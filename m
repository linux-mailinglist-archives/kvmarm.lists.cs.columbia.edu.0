Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D010E30AF9F
	for <lists+kvmarm@lfdr.de>; Mon,  1 Feb 2021 19:41:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 545E74B3E5;
	Mon,  1 Feb 2021 13:41:50 -0500 (EST)
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
	with ESMTP id o6NeD1vtXoLk; Mon,  1 Feb 2021 13:41:50 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1DDE74B3DA;
	Mon,  1 Feb 2021 13:41:49 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EB1724B3C1
 for <kvmarm@lists.cs.columbia.edu>; Mon,  1 Feb 2021 13:41:47 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 47vus3rcAVti for <kvmarm@lists.cs.columbia.edu>;
 Mon,  1 Feb 2021 13:41:47 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 109EC4B3C2
 for <kvmarm@lists.cs.columbia.edu>; Mon,  1 Feb 2021 13:41:47 -0500 (EST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1757A64DDF;
 Mon,  1 Feb 2021 18:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612204905;
 bh=8fU4c65Z1m9hAEXTu2nO/7NiTyQYV8Nb3hUN/A9d9Hg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=G93LfQThWoA3J0Ubyc13/PnHLPhueMAMe0lXcjaaX7CEGBd9sg5xj3kG3sWGzMa8j
 H6cMnZWXdJ9NLf8e3WUAh8gCfsbN5msU+B7CREiIJUdPqqh+jtCihLxeymamPOTSn2
 +RYAbHscpO9ESQIyQ3eTkortaed8fnGphCAQfsW3r5nZPzvPQ5Z8+kq0JNp8vGJT8B
 PfSGbvVr/pRUY6ZcODZVuLsZBYIOlxXO69S8WPaHO373WmeabGpXV59/R/Rm/4wQ/s
 NCpod4Jnz01Witb4Vj8OlMJaNBtDj0WMnLXZRAIl/i15QLW+Lw3QuUPk/eWrfcdmL1
 0cx62+JEpnm8Q==
Date: Mon, 1 Feb 2021 18:41:39 +0000
From: Will Deacon <will@kernel.org>
To: Quentin Perret <qperret@google.com>
Subject: Re: [RFC PATCH v2 08/26] KVM: arm64: Make kvm_call_hyp() a function
 call at Hyp
Message-ID: <20210201184139.GG15632@willie-the-truck>
References: <20210108121524.656872-1-qperret@google.com>
 <20210108121524.656872-9-qperret@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210108121524.656872-9-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, kernel-team@android.com, android-kvm@google.com,
 Catalin Marinas <catalin.marinas@arm.com>, Fuad Tabba <tabba@google.com>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Marc Zyngier <maz@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, kvmarm@lists.cs.columbia.edu
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

On Fri, Jan 08, 2021 at 12:15:06PM +0000, Quentin Perret wrote:
> kvm_call_hyp() has some logic to issue a function call or a hypercall
> depending the EL at which the kernel is running. However, all the code
> compiled under __KVM_NVHE_HYPERVISOR__ is guaranteed to run only at EL2,
> and in this case a simple function call is needed.
> 
> Add ifdefery to kvm_host.h to symplify kvm_call_hyp() in .hyp.text.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/kvm_host.h | 6 ++++++
>  1 file changed, 6 insertions(+)

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
