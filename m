Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 82E1534229D
	for <lists+kvmarm@lfdr.de>; Fri, 19 Mar 2021 17:58:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 16DB14B671;
	Fri, 19 Mar 2021 12:58:31 -0400 (EDT)
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
	with ESMTP id Rvs7FWgQzvGg; Fri, 19 Mar 2021 12:58:30 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 063894B691;
	Fri, 19 Mar 2021 12:58:30 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2B7F04B659
 for <kvmarm@lists.cs.columbia.edu>; Fri, 19 Mar 2021 12:58:29 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WANHTEztcwMB for <kvmarm@lists.cs.columbia.edu>;
 Fri, 19 Mar 2021 12:58:28 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 1159A4B630
 for <kvmarm@lists.cs.columbia.edu>; Fri, 19 Mar 2021 12:58:28 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7927261953;
 Fri, 19 Mar 2021 16:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616173107;
 bh=oWRlc58V9GPpmhVKr28TgLiGNUEVGrMp7yMwubglgCM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oP3rci4WbJRzdmIiKwS/z2XA5+6ILC5H/WgwOYc3fDAojChlIHPmnnhBzFyt1di/+
 1VrXpQImknmbD+9jP8HIUldavxYWsTFQTGKFZLNvl4xw0NlT4dWsUKfu0MvQjAw59u
 z+DzsNMqay0XAhB568J9x/MsmLEtfQCxkngjxxcq0ldf/OGCQCCJV9K/ZtRnNXKpxh
 y8ljQVbhpd8ih378xH/9A/NpRr6L0hamGq+fO9h3QBgyX+gRxwE7Kk1CEufthB4Lnf
 4iiVo+iesTvnonBZBL4zsqUTLIQAq71owzvEim+UBdJgrP0F/ZVbEG6AaMMZ2yaPzh
 y18u+bItojd5A==
Date: Fri, 19 Mar 2021 16:58:22 +0000
From: Mark Brown <broonie@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2 05/11] arm64: sve: Provide a conditional update
 accessor for ZCR_ELx
Message-ID: <20210319165822.GI5619@sirena.org.uk>
References: <20210318122532.505263-1-maz@kernel.org>
 <20210318122532.505263-6-maz@kernel.org>
 <20210319164236.GH5619@sirena.org.uk>
 <45a7868d83eaaef2e5d0f6e730c9c8f2@kernel.org>
MIME-Version: 1.0
In-Reply-To: <45a7868d83eaaef2e5d0f6e730c9c8f2@kernel.org>
X-Cookie: No purchase necessary.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kernel-team@android.com, kvm@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, kvmarm@lists.cs.columbia.edu,
 Will Deacon <will@kernel.org>, dave.martin@arm.com,
 linux-arm-kernel@lists.infradead.org, daniel.kiss@arm.com
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
Content-Type: multipart/mixed; boundary="===============0561577936461716095=="
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu


--===============0561577936461716095==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Q59ABw34pTSIagmi"
Content-Disposition: inline


--Q59ABw34pTSIagmi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 19, 2021 at 04:51:46PM +0000, Marc Zyngier wrote:
> On 2021-03-19 16:42, Mark Brown wrote:

> > Do compilers actually do much better with this than with a static
> > inline like the other functions in this header?  Seems like something
> > they should be figuring out.

> It's not about performance or anything of the sort: in most cases
> where we end-up using this, it is on the back of an exception.
> So performance is the least of our worries.

> However, the "reg" parameter to read/write_sysreg_s() cannot
> be a variable, because it is directly fed to the assembler.
> If you want to use functions, you need to specialise them per
> register. At this point, I'm pretty happy with a #define.

Ah, that makes sense - it was more of a "that's weird" than "that's
actually a problem", hence the Reviwed-by.

--Q59ABw34pTSIagmi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBU2C0ACgkQJNaLcl1U
h9Ajqwf9EMDQaypMDIWe3hvFmJpocQXYj8Z8pZV17DmNX8BsxorubMG4MZYXbAy3
Y6KQsdym6h98d123L43yudMJDZh1lUz5sxWtvbpTMkWShEaYWskz+Jt9u5FmVmRt
SKwrNpvVWtBUCKlmY2StbkfvvjAvHFrdP6dkSFUpNjXOORWvWFxEy3ON4Wh4/anX
1U+GXJN/udEiv1Gs2h1b+UWW7z2eDpfNImt1A/KekSoXH+6CiAc/DzV0PA3xelo/
YC4JLIPlLsdBT0wXPmY3pgAATgWM2j0cg/XLPZfylA88kgurHWHaZmq7H+rYO9xI
Jrx+XlOA0rjFsAI+OlH5tBWUdb72IQ==
=agRA
-----END PGP SIGNATURE-----

--Q59ABw34pTSIagmi--

--===============0561577936461716095==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm

--===============0561577936461716095==--
