Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7762EBE46
	for <lists+kvmarm@lfdr.de>; Wed,  6 Jan 2021 14:11:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7B7434B35D;
	Wed,  6 Jan 2021 08:11:10 -0500 (EST)
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
	with ESMTP id 8Y12Z1aWZydS; Wed,  6 Jan 2021 08:11:10 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 364154B34D;
	Wed,  6 Jan 2021 08:11:09 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D4EEB4B32B
 for <kvmarm@lists.cs.columbia.edu>; Wed,  6 Jan 2021 08:11:07 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Mhc-Md40Y2yK for <kvmarm@lists.cs.columbia.edu>;
 Wed,  6 Jan 2021 08:11:06 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id ACAA34B30E
 for <kvmarm@lists.cs.columbia.edu>; Wed,  6 Jan 2021 08:11:06 -0500 (EST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1F7AF22EBD;
 Wed,  6 Jan 2021 13:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1609938665;
 bh=79wddeIkl6fxtztJZXYazG9ptPsHlnjqs/ligBQXeMs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hOzTNsUZRihG5hwg4TULYCcxSKgCU6r010mu39TRym7YLpOhDKFtVfI3v4cU1TtEo
 J6MKaaqzwtTHyaOLn4auZKqaFjzotTiWHYuPNh2LGtBrEWPwSvNFWWSEK5zy4grMy2
 kuubSjxLqyIy9i7lpG2q7XpMUkJliW3sGOUGSgeHgA43lBDEXjhufwIGhcUrBlsgsR
 EMyjD8YWQBiaFQLlVnPwlXPvtEa9zzME1+6S3n2IwzrAYiKTUx2pD7KiIx+n8iscQp
 5l5tY3A8+2pi7h5RcuBjluaHZYxZ9IOCyGA6jHVZxcE/cNLSGq3FSmiKvpX5ZtS6pH
 THoMKkqSI5fzA==
Date: Wed, 6 Jan 2021 13:10:37 +0000
From: Mark Brown <broonie@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH v6 4/5] arm64: Add support for SMCCC TRNG entropy source
Message-ID: <20210106131037.GD4752@sirena.org.uk>
References: <20210106103453.152275-1-andre.przywara@arm.com>
 <20210106103453.152275-5-andre.przywara@arm.com>
MIME-Version: 1.0
In-Reply-To: <20210106103453.152275-5-andre.przywara@arm.com>
X-Cookie: Happy feast of the pig!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Theodore Ts'o <tytso@mit.edu>, Catalin Marinas <catalin.marinas@arm.com>,
 Linus Walleij <linus.walleij@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>,
 linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 kvmarm@lists.cs.columbia.edu, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
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
Content-Type: multipart/mixed; boundary="===============8205609677858372413=="
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu


--===============8205609677858372413==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UfEAyuTBtIjiZzX6"
Content-Disposition: inline


--UfEAyuTBtIjiZzX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 06, 2021 at 10:34:52AM +0000, Andre Przywara wrote:
> The ARM architected TRNG firmware interface, described in ARM spec
> DEN0098, defines an ARM SMCCC based interface to a true random number
> generator, provided by firmware.
> This can be discovered via the SMCCC >=v1.1 interface, and provides
> up to 192 bits of entropy per call.

Reviewed-by: Mark Brown <broonie@kernel.org>

--UfEAyuTBtIjiZzX6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/1tswACgkQJNaLcl1U
h9AU0gf/WEpGA7/Gqcj19WM0HyGcWr3K5f9j/Oet7jlOJd3xp5/OK/lHnRGxQ3UT
u51f8W2bmXF6OQ645seYsM+hEkcDJq+VFk+/wFE2w7TORZRLs1r9tFb6KrWrOCt2
A6ogtATKDYDwQeYIzf5+Ed3h/BP1Kgs3bPKo65hBulxWZUnRpIm3JlZegTGYC7hz
IXW3Ok1pRiyBbzBSR90NC8MW3TfPrBQEZEz8cmdSwu9ft1uLJqFumPB7nFVv747q
lCno+cS55Ikyj2OrdzQTLmsIYYutBgfd5yP9h3LHRIXZz5NC6eWlkKMqx/gL/sTO
XHQHqe3gdxNQ5gduTzONG4LqoOrw6Q==
=FSJJ
-----END PGP SIGNATURE-----

--UfEAyuTBtIjiZzX6--

--===============8205609677858372413==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm

--===============8205609677858372413==--
