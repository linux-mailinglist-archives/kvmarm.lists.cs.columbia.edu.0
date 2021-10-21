Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id EDE8A43661B
	for <lists+kvmarm@lfdr.de>; Thu, 21 Oct 2021 17:24:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6F8154B18F;
	Thu, 21 Oct 2021 11:24:33 -0400 (EDT)
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
	with ESMTP id GjwxNIXPm-wQ; Thu, 21 Oct 2021 11:24:33 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 110714B161;
	Thu, 21 Oct 2021 11:24:32 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 423134B159
 for <kvmarm@lists.cs.columbia.edu>; Thu, 21 Oct 2021 11:24:31 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9mhSA7AFXsSV for <kvmarm@lists.cs.columbia.edu>;
 Thu, 21 Oct 2021 11:24:30 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 21D2249FB7
 for <kvmarm@lists.cs.columbia.edu>; Thu, 21 Oct 2021 11:24:30 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id A1C4161183;
 Thu, 21 Oct 2021 15:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634829869;
 bh=tUrSTzrgcnXRxuolPC5YiqjKQYQV19z+OKGtoBE//Ew=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pEad02ay6+Bct21u4Vr3aCBZdjlooRsUJnBfQvsnjOD7ouqCLu2106vDuZdol0SI9
 CXD6az+sk29AOvUuVipq6vF9bGcBcU6mEv43pCJwPUx1uRGndrx14G7P7sKLiuczJV
 xFjHPuLwzKyr0YYKOvKy7lLEPLxjrPRnnbyA1p9z6wv6nUagqIzBaxw0n+8uY7aLyG
 5rgzto4O73JpcwCWJjRrecfjMxUR7idrJ2lPtI1OfeisTMkjmxi5fduCdKwFTbhFfw
 QLNo56f+Nakx3mmfJuDqZgudQ9cidMlkk9aD4+/opn2bt73Mk09p/91U9Y+bd8JJ++
 y3fs+t0nYtnYQ==
Date: Thu, 21 Oct 2021 16:24:26 +0100
From: Mark Brown <broonie@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 2/4] KVM: arm64: Introduce flag shadowing
 TIF_FOREIGN_FPSTATE
Message-ID: <YXGGKkQw27YiMBeP@sirena.org.uk>
References: <20211021151124.3098113-1-maz@kernel.org>
 <20211021151124.3098113-3-maz@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20211021151124.3098113-3-maz@kernel.org>
X-Cookie: I program, therefore I am.
Cc: kernel-team@android.com, kvm@vger.kernel.org, Will Deacon <will@kernel.org>,
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
Content-Type: multipart/mixed; boundary="===============5445180050178714997=="
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu


--===============5445180050178714997==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="L8Wd2CqiPfVWhZp9"
Content-Disposition: inline


--L8Wd2CqiPfVWhZp9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 21, 2021 at 04:11:22PM +0100, Marc Zyngier wrote:
> We currently have to maintain a mapping the thread_info structure
> at EL2 in order to be able to check the TIF_FOREIGN_FPSTATE flag.
>=20
> In order to eventually get rid of this, start with a vcpu flag that
> shadows the thread flag on each entry into the hypervisor.

Reviewed-by: Mark Brown <broonie@kernel.org>

--L8Wd2CqiPfVWhZp9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFxhikACgkQJNaLcl1U
h9BEwQf/esARvjGvexFVvEy7ZJkEtcEGWDwcI7fFBSYm35mVfsJxUU/14LDIPmci
EOzcELKvXBXccR+fJ+DdxtOkJJV/rB6vl1Iyg4ikNaNYbFENyYkkz0gyOtlXSkoH
nc9fUiPu4/i1+re6CB+n1Fam4qzuavZ71WK7fXwo5hNwB+vc0GAKRKwD8fCyMlcQ
7f/0JC25VkFkxpdY82tSo2RRRC/m5E6CXJtj0WnSM/q1yfKI/w75j4lDiO78w8+x
S3IRKg0aZSyiW/Kv05IfRFcO/xNXiOuLwRQ/+7+VuL34njdcA+UmASrJWmTBwV+T
wPCL4eMWVSK3O8SD6oohjJ/I3LOrRA==
=z7rI
-----END PGP SIGNATURE-----

--L8Wd2CqiPfVWhZp9--

--===============5445180050178714997==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm

--===============5445180050178714997==--
