Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 693774C499D
	for <lists+kvmarm@lfdr.de>; Fri, 25 Feb 2022 16:52:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AE24B4B9E8;
	Fri, 25 Feb 2022 10:52:54 -0500 (EST)
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
	with ESMTP id DEwvAMKgpTt6; Fri, 25 Feb 2022 10:52:54 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5D1904B9C4;
	Fri, 25 Feb 2022 10:52:53 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4ED864B8CE
 for <kvmarm@lists.cs.columbia.edu>; Fri, 25 Feb 2022 10:52:52 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AITeaOknUmtb for <kvmarm@lists.cs.columbia.edu>;
 Fri, 25 Feb 2022 10:52:51 -0500 (EST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 23FE34B8BF
 for <kvmarm@lists.cs.columbia.edu>; Fri, 25 Feb 2022 10:52:51 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 28EFC61A32;
 Fri, 25 Feb 2022 15:52:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A8B7C340F0;
 Fri, 25 Feb 2022 15:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1645804369;
 bh=M5bu53xphKA8fCFggR4QUQSIC9kxcdVVWdDnb2wz5CI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Nwsgvfze3p8nNHBixhpEl67KGpEl+AZmhjNVjBWYy8Bqw7M2piDgoB8gxXhTLaAi0
 8I8YGVjs7x08fvdfn3CY1poVXuNrQNY0NDhOa5S/NrTgfN+fS+977RdQuZu16us4TI
 F7arSIigh6QshH96SSkF5SwPa8i+cGQroDebOB2aC6YTbpR8jeNt42QNYz0mGSG63u
 a8HAKOgRgM9WP5fQt/WIjgIqmleUIYxSH7Xvh+qGYurpdSKMvvaFAdVXK5AYwROmp/
 R31nea1c+oWI7zOBTOdHAzGBB5lZF7071jsuqvjhMuzP3kzazBNaM/UNDq7Sb0lxQj
 2c9ne5YNG+YqA==
Date: Fri, 25 Feb 2022 15:52:42 +0000
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
 Mark Brown <broonie@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v11 00/40] arm64/sme: Initial support for the Scalable
 Matrix Extension
Message-ID: <20220225155241.GA20310@willie-the-truck>
References: <20220207152109.197566-1-broonie@kernel.org>
 <164579991080.3691228.14311210559888008730.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <164579991080.3691228.14311210559888008730.b4-ty@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
 Luis Machado <luis.machado@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>,
 kernel-team@android.com, linux-arm-kernel@lists.infradead.org,
 linux-kselftest@vger.kernel.org, Alan Hayward <alan.hayward@arm.com>,
 kvmarm@lists.cs.columbia.edu, Salil Akerkar <Salil.Akerkar@arm.com>
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

On Fri, Feb 25, 2022 at 03:50:12PM +0000, Will Deacon wrote:
> On Mon, 7 Feb 2022 15:20:29 +0000, Mark Brown wrote:
> > This series provides initial support for the ARMv9 Scalable Matrix
> > Extension (SME).  SME takes the approach used for vectors in SVE and
> > extends this to provide architectural support for matrix operations.  A
> > more detailed overview can be found in [1].
> > 
> > For the kernel SME can be thought of as a series of features which are
> > intended to be used together by applications but operate mostly
> > orthogonally:
> > 
> > [...]
> 
> Applied patch 5 to arm64 (for-next/kselftest), thanks!
> 
> [05/40] kselftest/arm64: signal: Allow tests to be incompatible with features
>         https://git.kernel.org/arm64/c/32de73e89099

I also applied 1-3 to for-next/fpsimd, but the 'thanks' file got overwritten
before I sent it!

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
