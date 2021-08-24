Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 330503F6151
	for <lists+kvmarm@lfdr.de>; Tue, 24 Aug 2021 17:10:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9BC004B255;
	Tue, 24 Aug 2021 11:10:53 -0400 (EDT)
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
	with ESMTP id zH-BTJGDAf98; Tue, 24 Aug 2021 11:10:53 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 289784B1E4;
	Tue, 24 Aug 2021 11:10:49 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3C3A34B1B4
 for <kvmarm@lists.cs.columbia.edu>; Tue, 24 Aug 2021 11:10:48 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xwQ5Iwi0gP9X for <kvmarm@lists.cs.columbia.edu>;
 Tue, 24 Aug 2021 11:10:43 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 31E7B4B1B5
 for <kvmarm@lists.cs.columbia.edu>; Tue, 24 Aug 2021 11:10:43 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C71660231;
 Tue, 24 Aug 2021 15:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629817842;
 bh=xbsICZp6mkLddzDKec4upeHDpoZKhXrk8ivZMxPTVas=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kXnhCV4Ed2wYhXhYvsBDys/BvDWYLGc3FNy/oR/jlqgyOddudf2iSKqvHT5MRvzo2
 G9gHAStv27tWYPlvu+AjRPbed0FwdliNMKUHfoXl6MwPbkGlv7ew5mwFHhMfcdcQeR
 l3/fjVs1iOoC0kyRetjUuwRjFFu40syhdICG0lGVT0ACsIn2ObdCsJlsHihFX7NDc4
 U7oK58l5tMC59o+GwKOR7F/hNzNcz1eapRYcmVxbgH8A1xyXtf/GsWtWf9kB9H8DeK
 vCwU2MyqqMY6W43icSzQCpVx7DuZ0uCGZM0QRthHrSQNyXLn5DreU2OsyMnRGQCOZc
 dvUWajLk6XsDw==
Date: Tue, 24 Aug 2021 16:10:15 +0100
From: Mark Brown <broonie@kernel.org>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Subject: Re: [PATCH] arm64: Do not trap PMSNEVFR_EL1
Message-ID: <20210824151015.GB4393@sirena.org.uk>
References: <20210824132459.562923-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
In-Reply-To: <20210824132459.562923-1-alexandru.elisei@arm.com>
X-Cookie: Sentient plasmoids are a gas.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: maz@kernel.org, kvmarm@lists.cs.columbia.edu,
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
Content-Type: multipart/mixed; boundary="===============6306476270014159603=="
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu


--===============6306476270014159603==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uQr8t48UFsdbeI+V"
Content-Disposition: inline


--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 24, 2021 at 02:24:59PM +0100, Alexandru Elisei wrote:

> Commit 31c00d2aeaa2 ("arm64: Disable fine grained traps on boot") zeroed
> the fine grained trap registers to prevent unwanted register traps from
> occuring. However, for the PMSNEVFR_EL1 register, the corresponding
> HDFGRTR_EL2.nPMSNEVFR_EL1 field must be 1 to disable trapping. Set the
> field to 1 if FEAT_SPEv1p2 is detected.

Oh, that's a shame :/  I wonder why this feature is different to the
others, I just had a quick check and didn't see any other issues but...

> Based on v5.14-rc7. Also, we could write 1 << 62 to HDFGRTR_EL2 unconditi=
onally
> since the field is RAZ/WI if !FEAT_SPEv1p2. I don't have a strong prefere=
nce for
> either approaches, but I chose this implementation because it's clearer (=
even
> though it's more verbose and it's one extra trap on NV).

Yes, the explicit feature check is both clearer and more conservative -
it's unlikely to have a practical impact but=20

> At this point, I am inclined to think it's a model bug because reading wo=
rks,
> but writing causes a hang and that looks very suspicious to me. I'm going=
 to
> open a model bug internally and see what comes of it.

=2E..are you sure this isn't that the same issue also exists with the
equivalent field HDFGWTR_EL2 - glancing at the XML it appears to have
the same issue?  One of the fine grained aspects of fine grained traps
is that there's separate read and write traps!

--uQr8t48UFsdbeI+V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmElC9YACgkQJNaLcl1U
h9AazwgAgidV6Oyh3QWl/Vypku7ljNKRuouTy5Z3/kh1J7KPdJVLlDhfc/1eDvS4
FQkFVWx9MBiCkBS/khMLutVCP02qQlCSdfY722bYNlxCZOubcqSHsg64bln27b1i
tn8L0ZYLZRlIPdrnLJDkZ4BAuIFHgWcL4CvMgIPKnM0ypjv+3Q9xcUAyb87CJwl4
zq7F0u0WRtJ+rj0tZK9nNjwTAtkbhPeB385PU5+9S87SopilekUweKSo9P4me499
aJhyG20ZStr4wBS2o2FG6TW31MznvdsDE6RO/B7KzrbRG48CTrLCDlTVJeb50CzW
d6qYSyhRLY9S5qg6ShMTOQLU2BdPEg==
=JYP4
-----END PGP SIGNATURE-----

--uQr8t48UFsdbeI+V--

--===============6306476270014159603==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm

--===============6306476270014159603==--
