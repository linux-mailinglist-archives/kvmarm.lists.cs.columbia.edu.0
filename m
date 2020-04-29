Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 072191BEC23
	for <lists+kvmarm@lfdr.de>; Thu, 30 Apr 2020 00:43:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 646C54B21B;
	Wed, 29 Apr 2020 18:43:08 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.908
X-Spam-Level: 
X-Spam-Status: No, score=0.908 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, SPF_HELO_PASS=-0.001,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@canb.auug.org.au
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E3uHIkUsRGRv; Wed, 29 Apr 2020 18:43:08 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 178B34B0E1;
	Wed, 29 Apr 2020 18:43:07 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B6B844B4AF
 for <kvmarm@lists.cs.columbia.edu>; Wed, 29 Apr 2020 18:43:05 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Vd14A8SIAAzn for <kvmarm@lists.cs.columbia.edu>;
 Wed, 29 Apr 2020 18:43:04 -0400 (EDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 2F76A4B384
 for <kvmarm@lists.cs.columbia.edu>; Wed, 29 Apr 2020 18:43:04 -0400 (EDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 49CD6v5YwNz9sRY;
 Thu, 30 Apr 2020 08:42:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1588200179;
 bh=1h58IcwauZ4ieV/uiHpLyfbAGYbxHiR+Ot6OY96Lo48=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=s/+FfL/QjJDjldOo77wT/kV1+GR2AquGHvWzTOtKoj3GAQKSAEfvUouu1eNhlLF//
 lNJRvXB1He4aNJcOIx5mvp9Ly6RwVGo2XkPKmPTvsmySYJXkh/EDMJYLoRebVZra71
 yYYHVfR++Lcmpok3mFoB2/BhSyeMY2ESQMAGXNo0z4nMI8+KDdt06yatUstTB6xdUQ
 1jJ2eoft45o89U3oEcoDv1/cLNSclF2MB7TGdkj3laJ6xYTjMuUfDvt76UYA8uhi+I
 RqWRoryhTv6ht8jriyQmq3iy/6PLRQ1e9SHRXIqOGu7XAgzRI7CTN3a4BOKQ393Lbb
 bB3QdoG8cPvNg==
Date: Thu, 30 Apr 2020 08:42:44 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] arm64: kvm: fix gcc-10 shift warning
Message-ID: <20200430084244.0ab7123e@canb.auug.org.au>
In-Reply-To: <20200429185657.4085975-1-arnd@arndb.de>
References: <20200429185657.4085975-1-arnd@arndb.de>
MIME-Version: 1.0
Cc: Rich Felker <dalias@libc.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Catalin Marinas <catalin.marinas@arm.com>, Paul Mackerras <paulus@samba.org>,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
 Jonas Bonn <jonas@southpole.se>, Brian Cain <bcain@codeaurora.org>,
 Marc Zyngier <maz@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Ley Foon Tan <ley.foon.tan@intel.com>, Mike Rapoport <rppt@linux.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Fenghua Yu <fenghua.yu@intel.com>,
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
Content-Type: multipart/mixed; boundary="===============2089886503844784669=="
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

--===============2089886503844784669==
Content-Type: multipart/signed; boundary="Sig_/yXfoBOelc92G7LHwh3.3rP7";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/yXfoBOelc92G7LHwh3.3rP7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 29 Apr 2020 20:56:20 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
>
> gcc-10 warns that the 32-bit zero cannot be shifted more than
> 32 bits to the right:
>=20
> arch/arm64/kvm/../../../virt/kvm/arm/mmu.c: In function 'clear_hyp_p4d_en=
try':
> arch/arm64/include/asm/pgtable.h:630:35: error: right shift count >=3D wi=
dth of type [-Werror=3Dshift-count-overflow]
>   630 | #define pud_index(addr)  (((addr) >> PUD_SHIFT) & (PTRS_PER_PUD -=
 1))
>       |                                   ^~
> arch/arm64/include/asm/memory.h:271:45: note: in definition of macro '__p=
hys_to_virt'
>   271 | #define __phys_to_virt(x) ((unsigned long)((x) - physvirt_offset))
>       |                                             ^
> arch/arm64/include/asm/pgtable.h:633:42: note: in expansion of macro '__v=
a'
>   633 | #define pud_offset(dir, addr)  ((pud_t *)__va(pud_offset_phys((di=
r), (addr))))
>       |                                          ^~~~
> arch/arm64/include/asm/pgtable.h:632:73: note: in expansion of macro 'pud=
_index'
>   632 | #define pud_offset_phys(dir, addr) (p4d_page_paddr(READ_ONCE(*(di=
r))) + pud_index(addr) * sizeof(pud_t))
>       |                                                                  =
       ^~~~~~~~~
> arch/arm64/include/asm/pgtable.h:633:47: note: in expansion of macro 'pud=
_offset_phys'
>   633 | #define pud_offset(dir, addr)  ((pud_t *)__va(pud_offset_phys((di=
r), (addr))))
>       |                                               ^~~~~~~~~~~~~~~
> arch/arm64/kvm/../../../virt/kvm/arm/mmu.c:510:36: note: in expansion of =
macro 'pud_offset'
>   510 |  pud_t *pud_table __maybe_unused =3D pud_offset(p4d, 0);
>       |                                    ^~~~~~~~~~
>=20
> This is harmless, and the warning is a little bit silly for
> a zero constant, but it's trivial to fix by making it an
> unsigned long, so do that.
>=20
> Fixes: 22998131ab33 ("arm64: add support for folded p4d page tables")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  virt/kvm/arm/mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> index 48d4288c5f1b..534d9798c3cb 100644
> --- a/virt/kvm/arm/mmu.c
> +++ b/virt/kvm/arm/mmu.c
> @@ -507,7 +507,7 @@ static void clear_hyp_pgd_entry(pgd_t *pgd)
> =20
>  static void clear_hyp_p4d_entry(p4d_t *p4d)
>  {
> -	pud_t *pud_table __maybe_unused =3D pud_offset(p4d, 0);
> +	pud_t *pud_table __maybe_unused =3D pud_offset(p4d, 0UL);
>  	VM_BUG_ON(p4d_huge(*p4d));
>  	p4d_clear(p4d);
>  	pud_free(NULL, pud_table);
> --=20
> 2.26.0
>=20

I have added that patch to linux-next today.

--=20
Cheers,
Stephen Rothwell

--Sig_/yXfoBOelc92G7LHwh3.3rP7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6qAuQACgkQAVBC80lX
0Gz0KwgAltuGmA1zwtzAqKn6eew96TO/8Bi3rhghdetwXLDdby3dVchN8/sqn4PV
aua1GpckOuMAcIg6UUO2FnXEEf5kbCCMZyQkvP15SwMv77Qk3H8aQxt+Wi4Kb9UE
gjscfS6i67I+fXQcXBxVgXefRyHkkx6xqs/XTmvKKGvVKWV+mT/Ac66LRP306FyU
XmGZDFha5PFqwNJboTw7/Tq9EgoyMc1ZIn7vntWhDs7fY5qkpfv/Aex6j215LVkP
BNVdOkGZ9/h7lHQbwgwmX2jhbT00RnUIvuMVCZVJyJSqyx+S6gmmH/pqELebT0rb
Ra4fLo+nxN1IrdSEfEQ9DLTndHFypQ==
=lrQg
-----END PGP SIGNATURE-----

--Sig_/yXfoBOelc92G7LHwh3.3rP7--

--===============2089886503844784669==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm

--===============2089886503844784669==--
