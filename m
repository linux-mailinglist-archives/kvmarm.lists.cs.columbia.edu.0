Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E57D74CA1E2
	for <lists+kvmarm@lfdr.de>; Wed,  2 Mar 2022 11:12:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3D94E49ED6;
	Wed,  2 Mar 2022 05:12:21 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xRjGJ9YIT3yF; Wed,  2 Mar 2022 05:12:21 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E09AF49ED1;
	Wed,  2 Mar 2022 05:12:19 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D20BB49EC0
 for <kvmarm@lists.cs.columbia.edu>; Wed,  2 Mar 2022 05:12:18 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4GSPMl7XeDG7 for <kvmarm@lists.cs.columbia.edu>;
 Wed,  2 Mar 2022 05:12:17 -0500 (EST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 46F3F49B07
 for <kvmarm@lists.cs.columbia.edu>; Wed,  2 Mar 2022 05:12:17 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 18609CE203B;
 Wed,  2 Mar 2022 10:12:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7053DC004E1;
 Wed,  2 Mar 2022 10:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646215932;
 bh=YgKpF4zSy+yYaEilN43vPrN5rclu1UHyi5Y9gnBFE8E=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=TeHrU+45hm5q3HE2xLt/GAkAOddSLQu2ejzHIHZwTP3ybt8a8XnQ/pMjJuMHb5S5L
 /h1Y8693i0olESxPuI4AeFxFiCmLWBKJVgRUG8b+oQdYU3PfP3SxPnz/XXIumAgnPt
 MP6lexq4KapzOWdGKbFRCp48gsxkWJkxDXBVfD58tU3eHDPfIHRAtUl+GxxDMJCvdH
 i79lwvOKfV0P7jqe1/JHdc/pYfjUoaMC3gCqtJOIUzrga1OjKzjOFM1yeOT62rOxKZ
 9Y3KXBXW7UxBsWLHti+VJBKshUnmIZE9BhqMLnUacPJafKDRBphtwM4FD5RGheYS5q
 ZXYF03hpVfUeg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1nPLxq-00Bdty-9L; Wed, 02 Mar 2022 10:12:10 +0000
Date: Wed, 02 Mar 2022 10:12:09 +0000
Message-ID: <878rts3bpi.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Qian Cai <quic_qiancai@quicinc.com>
Subject: Re: [PATCH v11 03/40] arm64: cpufeature: Always specify and use a
 field width for capabilities
In-Reply-To: <Yh6kqaR9FQXg8Q4w@qian>
References: <20220207152109.197566-1-broonie@kernel.org>
 <20220207152109.197566-4-broonie@kernel.org>
 <Yh6kqaR9FQXg8Q4w@qian>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: quic_qiancai@quicinc.com, broonie@kernel.org,
 catalin.marinas@arm.com, will@kernel.org, skhan@linuxfoundation.org,
 shuah@kernel.org, Basant.KumarDwivedi@arm.com, luis.machado@arm.com,
 szabolcs.nagy@arm.com, linux-arm-kernel@lists.infradead.org,
 linux-kselftest@vger.kernel.org, alan.hayward@arm.com,
 kvmarm@lists.cs.columbia.edu, Salil.Akerkar@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
 Will Deacon <will@kernel.org>, Luis Machado <luis.machado@arm.com>,
 Szabolcs Nagy <szabolcs.nagy@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Alan Hayward <alan.hayward@arm.com>,
 Mark Brown <broonie@kernel.org>, Salil
 Akerkar <Salil.Akerkar@arm.com>, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>, Shuah
 Khan <shuah@kernel.org>, kvmarm@lists.cs.columbia.edu,
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

On Tue, 01 Mar 2022 22:56:41 +0000,
Qian Cai <quic_qiancai@quicinc.com> wrote:
> 
> On Mon, Feb 07, 2022 at 03:20:32PM +0000, Mark Brown wrote:
> > Since all the fields in the main ID registers are 4 bits wide we have up
> > until now not bothered specifying the width in the code. Since we now
> > wish to use this mechanism to enumerate features from the floating point
> > feature registers which do not follow this pattern add a width to the
> > table.  This means updating all the existing table entries but makes it
> > less likely that we run into issues in future due to implicitly assuming
> > a 4 bit width.
> > 
> > Signed-off-by: Mark Brown <broonie@kernel.org>
> 
> Do we leave this one alone on purpose?
> 
>                 .desc = "GIC system register CPU interface",
>                 .capability = ARM64_HAS_SYSREG_GIC_CPUIF,
>                 .type = ARM64_CPUCAP_STRICT_BOOT_CPU_FEATURE,
>                 .matches = has_useable_gicv3_cpuif,
>                 .sys_reg = SYS_ID_AA64PFR0_EL1,
>                 .field_pos = ID_AA64PFR0_GIC_SHIFT,
>                 .sign = FTR_UNSIGNED,
>                 .min_field_value = 1,
>
> Since width == 0, it will generate an undefined behavior.

I don't think that's on purpose, and we should definitely address
this. Maybe we should have a warning if we spot an occurrence of
.width being 0.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
