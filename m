Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7A31D4B2C76
	for <lists+kvmarm@lfdr.de>; Fri, 11 Feb 2022 19:14:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B4BBD4A105;
	Fri, 11 Feb 2022 13:14:13 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.911
X-Spam-Level: 
X-Spam-Status: No, score=0.911 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_BLOCKED=0.001, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZYamYyC+BPVi; Fri, 11 Feb 2022 13:14:13 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1FB6849F53;
	Fri, 11 Feb 2022 13:14:12 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 236AD49EB3
 for <kvmarm@lists.cs.columbia.edu>; Fri, 11 Feb 2022 13:14:10 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kG1ltIy4PLmQ for <kvmarm@lists.cs.columbia.edu>;
 Fri, 11 Feb 2022 13:14:06 -0500 (EST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id E492F49EB2
 for <kvmarm@lists.cs.columbia.edu>; Fri, 11 Feb 2022 13:14:05 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 4B01961DE2;
 Fri, 11 Feb 2022 18:14:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BCAEC340E9;
 Fri, 11 Feb 2022 18:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1644603244;
 bh=AhgL4SP5wlwD+zr/JKbq/l2D8ucLJyESgKJCAelqRdQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=flJPl5F+zx7qwTRbFXA/4k03Dhre76dU9rSpHsRQRWxxbbXpGWuDdJ6/p7MKe3P6j
 13xIBFDtK2rKndtUAVrE76yETKrs5ypYFRtPNyBoaUjfhshnLP89nAkFST3MbHdRRX
 +nvwaKTG2rekg2vVCb8RvRXGGbnZFKMqlpANG8sqqCqIlIzYpT/CmDhY0ZhLEUwqVD
 m/QcNWmm6j8wbWidGEb8NR5a64IYRPnMouf7QMCc2ujVSrmLhYB5nBdpiTIvZxIwQW
 cFJ3Wc+hG9+7/7Kk1qv3ocJhhoCiJy9rkSmj1pOSXyDuBd08kJ2uvdk9Xaeu1sRQ6a
 ivgYiOu9ozLdQ==
Date: Fri, 11 Feb 2022 18:13:58 +0000
From: Mark Brown <broonie@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v11 06/40] arm64/sme: Provide ABI documentation for SME
Message-ID: <YganZni933HbRTmO@sirena.org.uk>
References: <20220207152109.197566-1-broonie@kernel.org>
 <20220207152109.197566-7-broonie@kernel.org>
 <YgVaTounTtunlGU6@arm.com> <YgVrbc4fFrA0Vjh2@sirena.org.uk>
 <YgaWmP+P7v9b2lLz@arm.com>
MIME-Version: 1.0
In-Reply-To: <YgaWmP+P7v9b2lLz@arm.com>
X-Cookie: do {
Cc: Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
 Will Deacon <will@kernel.org>, Luis Machado <luis.machado@arm.com>,
 Szabolcs Nagy <szabolcs.nagy@arm.com>, Marc Zyngier <maz@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org,
 linux-kselftest@vger.kernel.org, Alan Hayward <alan.hayward@arm.com>,
 Shuah Khan <shuah@kernel.org>, kvmarm@lists.cs.columbia.edu,
 Salil Akerkar <Salil.Akerkar@arm.com>
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
Content-Type: multipart/mixed; boundary="===============0206295217788886211=="
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu


--===============0206295217788886211==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YAmZ/SKZifOE9OWf"
Content-Disposition: inline


--YAmZ/SKZifOE9OWf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 11, 2022 at 05:02:16PM +0000, Catalin Marinas wrote:
> On Thu, Feb 10, 2022 at 07:45:49PM +0000, Mark Brown wrote:

> > If we don't preserve ZA then userspace will be forced to save it when
> > enabled which increases overall costs, if we do preserve ZA then it's no
> > more expensive for the kernel to save it than userspace, we avoid the
> > cost of restoring in the case where return directly to userspace without
> > context switching and if we do future work to save more lazily then we
> > may be able to avoid some of the saves.

> Thanks for the explanation and the PCS pointer. I guess doing the lazy
> saving scheme in the syscall handler is a lot more painful (faults etc.)
> and it's a user-only ABI/PCS, so we shouldn't tie the kernel into it.

Yes, other than the considerations around clone() it's clearly more
complicated to engage with.

> Given that Linux doesn't plan to use the ZA registers itself, in most
> cases it won't need to restore anything. But we still need to save the
> ZA registers on context switch in case the thread wakes up on a
> different CPU. How often do you reckon would the user do a syscall with
> active ZA?

I would expect it to be very rare that userspace would want to do a
syscall with ZA enabled, though obviously there's not a huge body of
real world SME code to validate that against yet.  The expected usage
pattern is that both ZA and SM are only enabled for fairly brief bursts
of intense computation and disabled when not actively used.  It's
possible that you will see things like logging during computation, or
perhaps streaming data to/from a running algorithm incrementally during
operation, generating syscalls so I wouldn't be surprised to see it
happen but it for most systems it should be a very small percentage of
system calls.

> > > What does that mean? Is this as per the sve.rst doc (unspecified but
> > > zeroed in practice)?

> > Yes, we will exit streaming mode and proceed as per sve.rst and the rest
> > of the ABI.

> So in this case we consider the syscall interface as non-streaming (as
> per the PCS terminology). Should we require that the PSTATE.SM is
> cleared by the user as well? Alternatively, we could make it
> streaming-compatible and just preserve it. Are there any drawbacks?
> kernel_neon_begin() could clear SM if needed.

In fact kernel_neon_begin() already disables PSTATE.SM since we need to
account for the case where userspace was preempted rather than issued a
syscall.  We could require that PSTATE.SM is disabled by the user,
though it's questionable what we could usefully and helpfully do about
it if they forget other than disable it anyway or generate a signal.

We could preserve PSTATE.SM, though since all the other register state
for streaming mode is shared with SVE I would expect that we should be
applying the SVE discard rules to it and there is therefore no other
state that should be retained.  As things stand this would either result
in more overhead or complicate the register save and restore a bit since
if we're in streaming mode we currently assume that we should save and
restore the full SVE register contents but normally in a syscall we only
need to save and restore the FPSIMD subset.  The overhead might go away
anyway as a result of general work on syscall optimisation for SVE,
though that work isn't done yet and may not end up working out that way.

Having said that as with ZA userspace can just exit streaming mode to
avoid any overhead having it enabled introduces and the common case is
expected to be that it will have done so due to the PCS, it should be an
extremely rare case - unlike keeping ZA active there doesn't seem to be
any case where it would be sensible to want to do this and the PCS means
you'd have to actively try to do so.

> > Largely just because it's more complicated to implement copying the ZA
> > backing store for this and it seemed more likely that someone would be
> > surprised by a new process getting stuck carrying a potentially large
> > copy of ZA around that it was unaware of than that someone would
> > actually want that to happen.  It's not a particularly strongly held
> > opinon.

> If PSTATE.ZA is valid and the user does a fork() (well, implemented as
> clone()), normally it expects a nearly identical state in the child.
> With clone() if a new thread is created, we likely don't need the
> additional ZA state. We got away with having to think about this for
> SVE as the state is lost on syscall. Here we risk having a vaguely
> defined ABI - fork() is disabled on arm64 for example but we do have
> clone() and clone3().

> Still thinking about this but maybe we could do something like always
> copy the ZA state unless CLONE_VM is passed for example. It is
> marginally more precise.

We should definitely write this up a bit more explictly whatever we do,
like I say I don't really have strong opinions here.

There's also the interaction with the lazy save state to consider -
TPIDR2 is cleared if CLONE_SETTLS is specified which would interfere
with any lazy state saving that had already happened, though hopefully
userspace is taking care of that as part of setting up the new thread so
I think it's fine.

--YAmZ/SKZifOE9OWf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIGp2UACgkQJNaLcl1U
h9AIQAf8D5srkxC+RZZ7YwZjzxYgVg8sz99TAumIpwsl9Np4inwRi8gYSPgCSW9Q
JEsYI4415LBWm2ZTluD7dL56JnwE2tb/4fhyygeYYdxiix+Hh9NEsQNTMHitrlqd
1D5+CmEKrFNe2xc1KWkppDFjJj+ajsUp+zY6I05k4gUBl37jbXbp4N8gQ6+9nhIP
ERSVGWt+ElhjMw4yCEc3xK6Pq19cKL4BvmgN2Bi3pD1HItVEa9OLkMlDi9GEm9k4
e2OFcolJ7nEMzsHpeV4/8Mrwn3XgC2wgfHPV6LbSnCTv+C3u5E4bB8BLD5w9K0D0
Vy6+LLlYi8r256HiWfRbA17I4ZLf0w==
=IVui
-----END PGP SIGNATURE-----

--YAmZ/SKZifOE9OWf--

--===============0206295217788886211==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm

--===============0206295217788886211==--
