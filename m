Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3D207618571
	for <lists+kvmarm@lfdr.de>; Thu,  3 Nov 2022 17:58:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 594374B0E6;
	Thu,  3 Nov 2022 12:58:47 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.017
X-Spam-Level: 
X-Spam-Status: No, score=-1.017 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1, FREEMAIL_FROM=0.001,
	RCVD_IN_SORBS_WEB=0.77, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@gmail.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jReEwA1e4mIE; Thu,  3 Nov 2022 12:58:47 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0B7D54B632;
	Thu,  3 Nov 2022 12:58:46 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id AC0C94B636
 for <kvmarm@lists.cs.columbia.edu>; Wed,  2 Nov 2022 23:50:25 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3Ei8ozUsumQx for <kvmarm@lists.cs.columbia.edu>;
 Wed,  2 Nov 2022 23:50:24 -0400 (EDT)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 3169D4B635
 for <kvmarm@lists.cs.columbia.edu>; Wed,  2 Nov 2022 23:50:24 -0400 (EDT)
Received: by mail-pj1-f42.google.com with SMTP id
 d59-20020a17090a6f4100b00213202d77e1so4034308pjk.2
 for <kvmarm@lists.cs.columbia.edu>; Wed, 02 Nov 2022 20:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iWVR2ehQGeZFXPOJNknn3hmzbHnYOWV57filXnjqjrU=;
 b=IljhQhIC/sgv7OmXIphyRoF1Fm2arV5E5U02Kgp8tUT+YAED6LwaG9RD4QoU9CUSP5
 1/JNzISZO7e0k7LVi4Nhh5KwB3CiEdhylwRBnpUuPf9JfG2iFOLa5bBg4N7u4W1/WhBl
 LJQGh6yVWhaw0tytwIyyV/ZB5HPOV0pCuqYcSOAT9NwusSA0CGBvX+EyWy3UKnp5kXPg
 nIFT6Dh82si3xpSAfsD2M3v8F8yWE/FhhpLtf3lkKEWv52m501EQ66Nykxayp1XTqDvL
 WAWBvQlIHGidKNnNKDn8JmAbCkreN9tLcEXmsdG3J1CBqteqkisOYXXjzr5N4tg3qu+Q
 7XoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iWVR2ehQGeZFXPOJNknn3hmzbHnYOWV57filXnjqjrU=;
 b=aL2fKNTg2VnMcfcWbm5xL5C7PC6GBOe2I5g8jm94Z8p3oTIKoGfD0ZwWAorjbsJd2W
 8i66wtxzudwLNfw8Eb4HKlH1ahKEmmHfX5x1Qs1oBwBQBxUbbRppVPYSw67c7NbvPdS+
 AqnQF+QVIhdmCmgbCOgJfnhWYknVgK4xpvRx8MC90+1vO2ItXxRG+sxcO0ccVOGmGy16
 32eqwc+uz9NG+kx53JnYPdx7SB6aMT05uNIYFGzARaZry33r2N24gL9US3SdpwHRM8xc
 DNPPO9DDX9Hptpc7TBtlhQU+GE1LxWVkzSQB4wZptGByjDdsuYiwAQgHPbtZ556j2mq+
 hbew==
X-Gm-Message-State: ACrzQf1iOoN1rIlJV/DTYhVE0KrplGIT7LJOVTvcxJEbOKSK5gXzZri8
 CRuSamJXIk23jjEfbEGHmSo=
X-Google-Smtp-Source: AMsMyM59vsw1ww2iJDViww6QqEMLB7bqz+DWsHRCrrgQ+b/6qP0v4EaYmz/ye+GUsaHp7b3ofc0NxA==
X-Received: by 2002:a17:90a:c78a:b0:212:e56b:2b17 with SMTP id
 gn10-20020a17090ac78a00b00212e56b2b17mr29293540pjb.51.1667447423005; 
 Wed, 02 Nov 2022 20:50:23 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-93.three.co.id. [180.214.232.93])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a170902e81200b001868d4600b8sm9150731plg.158.2022.11.02.20.50.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Nov 2022 20:50:21 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
 id 51DCA1032A1; Thu,  3 Nov 2022 10:50:18 +0700 (WIB)
Date: Thu, 3 Nov 2022 10:50:17 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Usama Arif <usama.arif@bytedance.com>
Subject: Re: [RFC 1/6] KVM: arm64: Document PV-lock interface
Message-ID: <Y2M6eU6xW7jjVQNx@debian.me>
References: <20221102161340.2982090-1-usama.arif@bytedance.com>
 <20221102161340.2982090-2-usama.arif@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20221102161340.2982090-2-usama.arif@bytedance.com>
X-Mailman-Approved-At: Thu, 03 Nov 2022 12:58:44 -0400
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 fam.zheng@bytedance.com, maz@kernel.org, punit.agrawal@bytedance.com,
 linux@armlinux.org.uk, liangma@liangbit.com, steven.price@arm.com,
 will@kernel.org, kvmarm@lists.cs.columbia.edu,
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
Content-Type: multipart/mixed; boundary="===============8334494174869380707=="
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu


--===============8334494174869380707==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0kw+g6XS/JN44czt"
Content-Disposition: inline


--0kw+g6XS/JN44czt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 02, 2022 at 04:13:35PM +0000, Usama Arif wrote:
> +    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D    =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +    Function ID:  (uint32)    0xC6000020
> +    PV_call_id:   (uint32)    The function to query for support.
> +                              Currently only PV_LOCK_PREEMPTED is suppor=
ted.
> +    Return value: (int64)     NOT_SUPPORTED (-1) or SUCCESS (0) if the r=
elevant
> +                              PV-lock feature is supported by the hyperv=
isor.
> +    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D    =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +PV_LOCK_PREEMPTED
> +    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D    =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +    Function ID:  (uint32)    0xC6000021
> +    Return value: (int64)     IPA of the pv lock data structure for this
> +                              VCPU. On failure:
> +                              NOT_SUPPORTED (-1)
> +    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D    =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +

You need to fix up these tables above:

---- >8 ----

diff --git a/Documentation/virt/kvm/arm/pvlock.rst b/Documentation/virt/kvm=
/arm/pvlock.rst
index 766aeef50b2d31..940a1cb221bc90 100644
--- a/Documentation/virt/kvm/arm/pvlock.rst
+++ b/Documentation/virt/kvm/arm/pvlock.rst
@@ -15,21 +15,23 @@ The existence of the PV_LOCK hypercall should be probed=
 using the SMCCC 1.1
 ARCH_FEATURES mechanism before calling it.
=20
 PV_LOCK_FEATURES
-    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D    =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D    =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
     Function ID:  (uint32)    0xC6000020
     PV_call_id:   (uint32)    The function to query for support.
                               Currently only PV_LOCK_PREEMPTED is supporte=
d.
     Return value: (int64)     NOT_SUPPORTED (-1) or SUCCESS (0) if the rel=
evant
                               PV-lock feature is supported by the hypervis=
or.
-    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D    =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D    =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 PV_LOCK_PREEMPTED
-    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D    =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D    =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
     Function ID:  (uint32)    0xC6000021
     Return value: (int64)     IPA of the pv lock data structure for this
                               VCPU. On failure:
                               NOT_SUPPORTED (-1)
-    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D    =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D    =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 The IPA returned by PV_LOCK_PREEMPTED should be mapped by the guest as nor=
mal
 memory with inner and outer write back caching attributes, in the inner

The similar fixup should also be made to the tables in
Documentation/virt/kvm/arm/pvtime.rst, though.

> +The IPA returned by PV_LOCK_PREEMPTED should be mapped by the guest as n=
ormal
> +memory with inner and outer write back caching attributes, in the inner
> +shareable domain.
> +
> +PV_LOCK_PREEMPTED returns the structure for the calling VCPU.
> +
> +PV lock state
> +-------------
> +
> +The structure pointed to by the PV_LOCK_PREEMPTED hypercall is as follow=
s:
> +
> ++-----------+-------------+-------------+-------------------------------=
--+
> +| Field     | Byte Length | Byte Offset | Description                   =
  |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> +| preempted |      8      |      0      | Indicate if the VCPU that owns=
  |
> +|           |             |             | this struct is running or not.=
  |
> +|           |             |             | Non-zero values mean the VCPU =
  |
> +|           |             |             | has been preempted. Zero means=
  |
> +|           |             |             | the VCPU is not preempted.    =
  |
> ++-----------+-------------+-------------+-------------------------------=
--+
> +
> +The preempted field will be updated to 1 by the hypervisor prior to sche=
duling
> +a VCPU. When the VCPU is scheduled out, the preempted field will be upda=
ted
> +to 0 by the hypervisor.
> +
> +The structure will be present within a reserved region of the normal mem=
ory
> +given to the guest. The guest should not attempt to write into this memo=
ry.
> +There is a structure per VCPU of the guest.
> +
> +For the user space interface see Documentation/virt/kvm/devices/vcpu.rst
> +section "4. GROUP: KVM_ARM_VCPU_PVLOCK_CTRL".

Use reST labels for cross-referencing to the documentation section:

---- >8 ----

diff --git a/Documentation/virt/kvm/arm/pvlock.rst b/Documentation/virt/kvm=
/arm/pvlock.rst
index 940a1cb221bc90..4e9d09b76ef033 100644
--- a/Documentation/virt/kvm/arm/pvlock.rst
+++ b/Documentation/virt/kvm/arm/pvlock.rst
@@ -62,5 +62,5 @@ The structure will be present within a reserved region of=
 the normal memory
 given to the guest. The guest should not attempt to write into this memory.
 There is a structure per VCPU of the guest.
=20
-For the user space interface see Documentation/virt/kvm/devices/vcpu.rst
-section "4. GROUP: KVM_ARM_VCPU_PVLOCK_CTRL".
+For the user space interface see :ref:`KVM_VCPU_TSC_CTRL in Generic vcpu
+interface documentation <kvm-vcpu-tsc-ctrl>`.
diff --git a/Documentation/virt/kvm/devices/vcpu.rst b/Documentation/virt/k=
vm/devices/vcpu.rst
index 223ac2fe62f01f..6532f61073a39c 100644
--- a/Documentation/virt/kvm/devices/vcpu.rst
+++ b/Documentation/virt/kvm/devices/vcpu.rst
@@ -194,6 +194,8 @@ base address must be 64 byte aligned and exist within a=
 valid guest memory
 region. See Documentation/virt/kvm/arm/pvtime.rst for more information
 including the layout of the stolen time structure.
=20
+.. _kvm-vcpu-tsc-ctrl:
+
 4. GROUP: KVM_VCPU_TSC_CTRL
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
=20

Also, you need to add the documentation to table of contents (index):

---- >8 ----

diff --git a/Documentation/virt/kvm/arm/index.rst b/Documentation/virt/kvm/=
arm/index.rst
index e8484843215808..b8499dc00a6a96 100644
--- a/Documentation/virt/kvm/arm/index.rst
+++ b/Documentation/virt/kvm/arm/index.rst
@@ -10,4 +10,5 @@ ARM
    hyp-abi
    hypercalls
    pvtime
+   pvlock
    ptp_kvm

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--0kw+g6XS/JN44czt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY2M6dAAKCRD2uYlJVVFO
o6ypAQC4gXIOLzJaG1xrERxYGFbFMVCxsI4H9zRtmvL0N59oZAD+I4W4aE89G8OC
aMB8yxTT1P3MYgIXYCERt69q1eOhAw0=
=7yrW
-----END PGP SIGNATURE-----

--0kw+g6XS/JN44czt--

--===============8334494174869380707==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm

--===============8334494174869380707==--
