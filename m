Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id DF04349CAA7
	for <lists+kvmarm@lfdr.de>; Wed, 26 Jan 2022 14:21:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1B46A411D2;
	Wed, 26 Jan 2022 08:21:28 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Hfv-HHwekGeE; Wed, 26 Jan 2022 08:21:27 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AAE0A41003;
	Wed, 26 Jan 2022 08:21:26 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2278A40E00
 for <kvmarm@lists.cs.columbia.edu>; Wed, 26 Jan 2022 08:21:25 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9+6QkUH26o4K for <kvmarm@lists.cs.columbia.edu>;
 Wed, 26 Jan 2022 08:21:23 -0500 (EST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id DC64240AFA
 for <kvmarm@lists.cs.columbia.edu>; Wed, 26 Jan 2022 08:21:23 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 129DA60F1D;
 Wed, 26 Jan 2022 13:21:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6455C340E3;
 Wed, 26 Jan 2022 13:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643203282;
 bh=fPMNkVvTGtEkb1FdmSeOFQ9ZC+OjP+x1qXbgEQWmxbk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=anfqCzhI3pGu70Eck98ANgaIj2RBKp42hlYgrjRdLVP+WrLFnRRgF9FGEnCvknvM3
 SfaHfvpvI0YM9lM10pp4yG2k+YCqjZXsJk0n2i83qFsSyPi8RppldYBUOsf/vvSvtR
 hlLkG2RqpZtr4SAgcC1AFNREzBXBspY8+9XEzGCV/aaib0Vq01uphIY9P+AFOnZDrE
 Y9r3KY7c6UuD20ZaeQHEGe4nRxKIAqHbiC6IYBW4HmxAW7t2eE/Ddje0CpHC5Z+IfJ
 8Uo//QrKk3k4u5iIpBOOJCb8+EhNk1OGo1avDhNd2F5ceyebRVuxrDS9s22W0E+O52
 l3RGErcCRpICw==
Date: Wed, 26 Jan 2022 13:21:17 +0000
From: Mark Brown <broonie@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] kselftest: kvm/arm64: Skip tests if we can't create a
 vgic-v3
Message-ID: <YfFKzWxNd5l26Ebk@sirena.org.uk>
References: <20220125192851.3907611-1-broonie@kernel.org>
 <87h79q7tln.wl-maz@kernel.org> <YfFEBlsUH+dMxmku@sirena.org.uk>
 <87czke7ima.wl-maz@kernel.org>
MIME-Version: 1.0
In-Reply-To: <87czke7ima.wl-maz@kernel.org>
X-Cookie: Use only in a well-ventilated area.
Cc: linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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
Content-Type: multipart/mixed; boundary="===============0705198005055769555=="
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu


--===============0705198005055769555==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gspqA5Mq/TOiapel"
Content-Disposition: inline


--gspqA5Mq/TOiapel
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 26, 2022 at 01:05:01PM +0000, Marc Zyngier wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > > So you now only test whether it is possible to create a virtual GICv3,
> > > but don't actually create it. How does this work?

> > Oh, that's rather obscure in the API - so the file descriptor returned
> > if the test flag is specified can't actually be used?

> No file descriptor is returned at all from the kernel, so you should
> always get -1 as populated by kvm_create_device().

> See virt/kvm/kvm_main.c::kvm_ioctl_create_device().

Ugh, right - the descriptor is returned separately to the return code
but is then mapped onto the return code by the library since the library
just aborts on error in the non-test case and in the test case the kernel
returns an inverted boolean which gets passed straight through.  Like I
say the API seems a bit confusing here.

--gspqA5Mq/TOiapel
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHxSswACgkQJNaLcl1U
h9Dsmgf/e8msOXlT7YykzDeLiWdBtZ7S3j8L7Q3+RRpswDfva7HRFzgu3hABYNIA
NFcX4iDBz4ATuI5fa3jQ+aBTf1XwBh1nCQQP7CBH6vTydkR1RFPJ4eRL9Km94yXJ
0b4GQF+vVLRAyiK93GpvKJhQBIB8VlOM6Xtt4fkWcBaLcRrBr1idEQYZKe8ttP/Q
hhhtMVcR8ojaxUpH5CNdeDCVMt42Sf0ayleoH4HKfBEJ9iyMSdDG1Rkr9f3fH2wU
5b5hrdQGaAhVoMW4MgWrxCh5bFnTU6Rioxx4gtkcPDYNPBoyZjAPs01kYJFCdSok
jMixYIz0sHLQL8cdNJv+x3IBxGWLMA==
=58KH
-----END PGP SIGNATURE-----

--gspqA5Mq/TOiapel--

--===============0705198005055769555==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm

--===============0705198005055769555==--
