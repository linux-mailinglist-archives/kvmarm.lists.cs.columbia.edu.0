Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5E46244D3
	for <lists+kvmarm@lfdr.de>; Thu, 10 Nov 2022 15:52:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 06D894BB43;
	Thu, 10 Nov 2022 09:52:22 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.788
X-Spam-Level: 
X-Spam-Status: No, score=-1.788 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, RCVD_IN_DNSWL_BLOCKED=0.001, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@intel.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rd2ePYTw8ZJY; Thu, 10 Nov 2022 09:52:20 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AA28C4BB8F;
	Thu, 10 Nov 2022 09:51:49 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8852A4BA64
 for <kvmarm@lists.cs.columbia.edu>; Wed,  9 Nov 2022 21:11:57 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZCuhFa1qEGgx for <kvmarm@lists.cs.columbia.edu>;
 Wed,  9 Nov 2022 21:11:56 -0500 (EST)
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id B25554BA63
 for <kvmarm@lists.cs.columbia.edu>; Wed,  9 Nov 2022 21:11:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1668046315; x=1699582315;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=8fFD56dxzIdCVv7sUmDRDuXnXsJhFv8J8DlSg219eA0=;
 b=WXhdLlQJ52zbyayiQ8QHs0wnZ+2OuIctXCeBvOD13BQgrVnx6bZbzt7Z
 QRMSt7V9QPA0zUPlsHxUbyxytSVNV9LiKSbevJmAD5+DeAL+x/uAz7zNK
 M2CyRNHp+TrkQ28II7bhSYY3rQvAGxm3oGAwd0r4vcliD+e3+n+Mzh3i4
 xDeLpQVQm3LAmrScEgwEwFO1QNjfky0Jq9716zRNm8QQpOo0qYibI/wzj
 64peGvl/Rz2D1pYdAs9xml5gI0UW4YuTvsxP+s2tqBnovWoyzj6uhap6A
 MXv67RBgzuV+8EozB0Fyp0yCPkt20vrkleDNTBRbq2XI4CU5WIcts41+5 Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="373297395"
X-IronPort-AV: E=Sophos;i="5.96,152,1665471600"; d="scan'208";a="373297395"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2022 18:11:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="636985967"
X-IronPort-AV: E=Sophos;i="5.96,152,1665471600"; d="scan'208";a="636985967"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orsmga002.jf.intel.com with ESMTP; 09 Nov 2022 18:11:53 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 18:11:53 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 9 Nov 2022 18:11:53 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 9 Nov 2022 18:11:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PKc3f6O5ecXuYZQzw3MEZnn7OI7/Jpjo+rKK6XDOMP00wnWNjBfCAPgpj3xi27Hmhfpu5tSsRVpxsRJlhDdATa36st6NpPmw7CEMuF9iQ4e2A+taeKHjkAUWGA1cwWamnKn8siwymuoxmJTWCantQ2mOKA6xLhXZMbvLIDHbQssa9ltjurJ3j89gO8H16CIQHjEcH52uxVcQk0i3Eu1PkhX9HUV9a37vyk64pdUBMQCgfpqlqSrctgVFIuKCL/rC1Zb45V0mA+FyKJdN2ytviaSasnW64wk7W5l1XYqtJ/KsP3wy7pOKCzIOchFvx1APCdEaT6f3+yG4FFJb+qBXDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8fFD56dxzIdCVv7sUmDRDuXnXsJhFv8J8DlSg219eA0=;
 b=BNABpsuqK60KWpARF95uBpTo2mB/dpHjKrW+fjDBa5jjkcQTCdS6+P0ALGQHO4TTi9g1sGyjNUudFAtwWyD1QgTTbpSxgp8K/UEd90DV9Ow8Vtg4z7Hv4vq8uJkfiW9Wh48CGt3jBstM0l21bZtaOIQbcb1uBt4gcoqXmM7v+Og+b33RdPJkHbpzJlGIz8aE3/xjZO4Gt3QLP211v0aDpgMl7taoKfSU5aqQT2LFXUEMAzwAw73hzq5QgQqm35Op2AtU/rB/wLUJBVWlZQXPOIg9lj0jzYA16dZB8xEBnXzfGvW4xRy7DOp86R1FC436E+iqg/xUURS/jUJLG1y0sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM8PR11MB5623.namprd11.prod.outlook.com (2603:10b6:8:25::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Thu, 10 Nov
 2022 02:11:47 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::6eb:99bf:5c45:a94b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::6eb:99bf:5c45:a94b%3]) with mapi id 15.20.5791.026; Thu, 10 Nov 2022
 02:11:47 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "farman@linux.ibm.com" <farman@linux.ibm.com>, "frankja@linux.ibm.com"
 <frankja@linux.ibm.com>, "Christopherson,, Sean" <seanjc@google.com>,
 "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>, "vkuznets@redhat.com"
 <vkuznets@redhat.com>, "chenhuacai@kernel.org" <chenhuacai@kernel.org>,
 "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
 "maz@kernel.org" <maz@kernel.org>, "anup@brainfault.org"
 <anup@brainfault.org>, "imbrenda@linux.ibm.com" <imbrenda@linux.ibm.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "borntraeger@linux.ibm.com"
 <borntraeger@linux.ibm.com>, "aleksandar.qemu.devel@gmail.com"
 <aleksandar.qemu.devel@gmail.com>
Subject: Re: [PATCH 38/44] KVM: Disable CPU hotplug during hardware enabling
Thread-Topic: [PATCH 38/44] KVM: Disable CPU hotplug during hardware enabling
Thread-Index: AQHY7xJy2pUg1L4bCkib6AOkbzD9bK43arEAgAAKuoA=
Date: Thu, 10 Nov 2022 02:11:47 +0000
Message-ID: <b198fe971cecd301f0c7c66028cfd71dd7ba7e62.camel@intel.com>
References: <20221102231911.3107438-1-seanjc@google.com>
 <20221102231911.3107438-39-seanjc@google.com>
 <88e920944de70e7d69a98f74005b49c59b5aaa3b.camel@intel.com>
In-Reply-To: <88e920944de70e7d69a98f74005b49c59b5aaa3b.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-2.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DM8PR11MB5623:EE_
x-ms-office365-filtering-correlation-id: 02decdf7-040c-44a0-8c2c-08dac2c0ebbe
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PHf0NSzOjavqdxwx8nOmYNdz/VMIy/Qk0wSK6vxb0p+aVVqdI1VKftPdVBnvUWZ6e39In6Tz5p6lMZnXhvGoi3nCB8RiHR1oYOpCtaLYjSY6nXWqCJ1r5EepuOhoLEYDvvScq/CrB52+cMQOJrZ/D2zY6EbDEb+cTsb/WGU3JczZ5RnMNX1OP5LYYxjd/Ffxp5CfnZDSJgq8PMMrpheGg/m4iYVav6h0XxZwDMM45INioCyGVuu38K1sQD4U/AnCpdFlmt+PgMoN2vfkxQE50GvzySgLio622eip2reCEr7L+fjMQFOkV6jssK7g6MDY8v+KNg4MUfV7jKMrhwyUO/5YmUyQQjF2DcxbfJavIUsK0b11Ya9bi6V2kgi7yfVNUu9l2ryjP0L4o9Nqoz1N80TJcW25bFpomb4HDua6ujVF1CcDuMZRAN8lWlTgMKbGK4d1km4R9BxtImbV8Y3e5aePXwAbmVMFdQyA4ryu/BXaPsJD1+WLk2KsnKU6eRpZ6nNpcKaRwJbNDVBDNgZ8udDJTXjYaNddwRqXxVBqB94efHN0On1wH3Lwd+LY/DaAGXa+dw7QSPD/r7YPY/zpFpmGNx3S3h5a7Cks3TZLS137htewHBZ9YtI5ayrcA98veAB8zQkughZ1J+GGF7liuPI6Gxsu8Gx3Pjl728gq23gbvOXMfOakFtIA1RfbKyb+Nauk9iLSJfY4TkLMcomkrisx6bnBdonYiQrYHJhUaD0HEmGq3jDvpdguyqjAdp+2PG3s2lVGDWxKsw8NNMgsxpyMvgt5S0Cvtfs7gAdnXJ0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR11MB5978.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199015)(41300700001)(8936002)(5660300002)(7416002)(7406005)(66476007)(66556008)(36756003)(6506007)(2906002)(8676002)(66946007)(4326008)(91956017)(83380400001)(66446008)(54906003)(71200400001)(64756008)(76116006)(110136005)(316002)(4001150100001)(82960400001)(86362001)(2616005)(6486002)(38100700002)(122000001)(26005)(921005)(38070700005)(478600001)(186003)(6512007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TmdpZVdEeWh6bmIvSWVHeW5YSEl1QXRVaXdOVGNPVU1jajd5TVpXNFZHckZN?=
 =?utf-8?B?cWo3UnJ3eWtJaGE3bFdTeHk0N3E4T3JDUlRwZVl3QzR0b3JUaDFaQ0xJbDVu?=
 =?utf-8?B?c0htQWhrVUR4aVZBejdjUCswQmhQcklnUkMzSUQveGxmQnZMZmhZak9CekZ0?=
 =?utf-8?B?ajZQQ0FOYlVSUDkxQncvWlg3QkVLY0luNm9pek9TdkZMdGU4V1dkaG1hNXVG?=
 =?utf-8?B?aHh6SmV5R2ZqdFd3OFNzdjhWU0tKcXNZT24yTHJVWVYyUWNYNURsbjM2SGM5?=
 =?utf-8?B?VkR6TkpOdC9SNHY3cENKR1lqYTlOSzJ1clYyV3VVcm1DWlVuUEYvM08wcnF3?=
 =?utf-8?B?QUExNkw1TDJ2S2RvOTV4YmdWWVE0MVl1ZXlXUmh0WGdrbnloNnBrZyt1aWk5?=
 =?utf-8?B?enlYKzNDalN2TFVSc2dEK2pOVW41djBiWXlWRWN6Tko4NUx0R0R4L0YyK2dO?=
 =?utf-8?B?YVVDSGVTdDRYUEREdnF0a3A5TmNWTDFlbUgvVS81NGxKZzIybWZYMWZBRGlE?=
 =?utf-8?B?ZzdmU2h1Y0R3bFZabGlTUVU4YnVTTnk1TFNITkdRQUNuTmc5dDMzRzJHWkJ6?=
 =?utf-8?B?ZFkrbmZKYzZCbjE5OUtSWEJRODBVem5BSzZVQ21DTjlrblpxbDduQXljaTRI?=
 =?utf-8?B?Mkd1Vk5pbzcvRDlDbUFwUXhaaTcxSTJTL081azBhQjZlUSsvU0lVMTRjY1U1?=
 =?utf-8?B?WE12MHczcTZYdkpTcjF3YndlQmtBMVI0VndmMnFxeWpqa0hzRTRYUmZHcEFh?=
 =?utf-8?B?d2FiekRzYnNxZ1JRTnU0VzF3VU94MUNlS2FQY2UyTE8yMXc4SHpwWFloZDdH?=
 =?utf-8?B?UHRUZE1qNzRTcW1MaTBucjFBSUZYZ1BwSjVVWndzTXkxUlJZTlBYMG5WSVl0?=
 =?utf-8?B?MzhyOEdsVkdobzU4b29JbTZ6YkpIZ1Vtbm9mRmFZQk5qRHBoQThxQ0V6cGM2?=
 =?utf-8?B?U09mUEJaNDVvV3lGMHg4KzBYYVRiYXVOQXd4Qlc4UXY5dEVnTXJxbloxRkh6?=
 =?utf-8?B?U2tEV0czbVJTZDVESHRiamNMOXdva1k3L2VqL1YxRjZlR3pXbHFTQzQrZ1pU?=
 =?utf-8?B?Q3U2aWJteGZaUlpXZlBSaExwNXVBaUhOaTNEYVhSc3hkcnh1Yms2OEhYWG44?=
 =?utf-8?B?R2xFbGxTTlRQemtFbE5TV3FITmJSaVAxRHU2d3hGeXU0eU1RY0VsTG1HMzdN?=
 =?utf-8?B?YXgyd21KUFhyMUdyYmdUbFBqS0VzOXliUjNBbnRnWTFCdkowT1NocGR1Qy8y?=
 =?utf-8?B?K3VCOTY1dE5lK2ZLQnBqTk02VXAzYlRLMlUvdU11MjZRL2NnalJ0WFNrWEtC?=
 =?utf-8?B?RTRtRnIzWnZraVFoczV6SjVRMXUrMkROQnBDTEtQbGFYbk1iZHlxVmVPS0ZL?=
 =?utf-8?B?cER3VnhmcUQxeGtjMW9makE0T25maTc3a21KaVlFSzQxdFJBMml6V2JlelQr?=
 =?utf-8?B?VXU5d3BmVS9ySDM2WjRBSHFrR0RWL0tWUkdENVdKVnJzc3labUpoek05OWgw?=
 =?utf-8?B?Qk1HTGczbWlaMmZMYnl3U2xNQmQyTFpHKzc5am1UOWZuOUJ3VFhhai92TUtx?=
 =?utf-8?B?eDhBWDREWFUra0g0Q1pXL2N4S25Ca25iNXFNYjU2MzdxRFBOV2ZzQmZwWnRu?=
 =?utf-8?B?UWdOS0xkRFZLR2tLN3pVNzVjVnV1cXp1UUZMbWkxQUtaaytlUmJJL1hDZVhl?=
 =?utf-8?B?SWRENG5QMFJzSERTcTNmYUpSdmhDTWlRaWNQbHlvMDh4QU40aEFoaDJkc1dj?=
 =?utf-8?B?T1ozMXdNLzdjZk1NU1ZwcHVGWjZ6ajlsUUlZektxV1BqRkpjSW91TEI0Ujk5?=
 =?utf-8?B?bXpxcXVVRXpMSFJTSlpyYlRBSExxTzB4S3QzdnpLZEYwV1VYQWV1YjhHMS91?=
 =?utf-8?B?R3hrZ3lIR0ZwUmVneEdhTmVzWTVhbWdQWFZ0cmJBWG5CY3NNeTJlRGwwak83?=
 =?utf-8?B?UDEwTGR5VlU4eUlWSGk2Y3RDY3hOSnNsRDUwL09yL1dPbUVyWWs2Wk9hOGdQ?=
 =?utf-8?B?ZUJjd3M0VkVjR1ZYUk1wMHJuWnVRUWdnQjBRL20vaFVJNW9heUlmZFVHVzkw?=
 =?utf-8?B?YjZUQVNIbGRaZ084Slh2UlpOa3ZpZ3FIdmdSNGlRT0crMVVtOVJNMTdjTkFq?=
 =?utf-8?B?Um54Z2I0V3dtRkRhTk01YVhyem1WRGcycFJuUzkvQ25IbHVNSlM4cVhzcnYw?=
 =?utf-8?B?ZlE9PQ==?=
Content-ID: <B4A2CA0E273F844484C40AD94BE99AB6@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02decdf7-040c-44a0-8c2c-08dac2c0ebbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2022 02:11:47.0676 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hByuIVfhEWT4kJl35EcjgXjzPKbzGsj73dS2OqYua83XdA7DPtfoKNWaiWU3PT3Kd9Ltp4Ze7lClZzRMn6LIQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5623
X-OriginatorOrg: intel.com
X-Mailman-Approved-At: Thu, 10 Nov 2022 09:51:44 -0500
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "david@redhat.com" <david@redhat.com>, "Yao, Yuan" <yuan.yao@intel.com>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "Gao, Chao" <chao.gao@intel.com>,
 "atishp@atishpatra.org" <atishp@atishpatra.org>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "Yamahata, Isaku" <isaku.yamahata@intel.com>,
 "farosas@linux.ibm.com" <farosas@linux.ibm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kvm-riscv@lists.infradead.org" <kvm-riscv@lists.infradead.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

T24gVGh1LCAyMDIyLTExLTEwIGF0IDAxOjMzICswMDAwLCBIdWFuZywgS2FpIHdyb3RlOg0KPiA+
IEBAIC05MjgzLDcgKzkyODMsMTMgQEAgc3RhdGljIGludA0KPiA+IGt2bV94ODZfY2hlY2tfcHJv
Y2Vzc29yX2NvbXBhdGliaWxpdHkoc3RydWN0IGt2bV94ODZfaW5pdF9vcHMgKm9wcykNCj4gPiDC
oAlpbnQgY3B1ID0gc21wX3Byb2Nlc3Nvcl9pZCgpOw0KPiA+IMKgCXN0cnVjdCBjcHVpbmZvX3g4
NiAqYyA9ICZjcHVfZGF0YShjcHUpOw0KPiA+IMKgDQo+ID4gLQlXQVJOX09OKCFpcnFzX2Rpc2Fi
bGVkKCkpOw0KPiA+ICsJLyoNCj4gPiArCSAqIENvbXBhdGliaWxpdHkgY2hlY2tzIGFyZSBkb25l
IHdoZW4gbG9hZGluZyBLVk0gYW5kIHdoZW4gZW5hYmxpbmcNCj4gPiArCSAqIGhhcmR3YXJlLCBl
LmcuIGR1cmluZyBDUFUgaG90cGx1ZywgdG8gZW5zdXJlIGFsbCBvbmxpbmUgQ1BVcyBhcmUNCj4g
PiArCSAqIGNvbXBhdGlibGUsIGkuZS4gS1ZNIHNob3VsZCBuZXZlciBwZXJmb3JtIGEgY29tcGF0
aWJpbGl0eSBjaGVjaw0KPiA+IG9uDQo+ID4gKwkgKiBhbiBvZmZsaW5lIENQVS4NCj4gPiArCSAq
Lw0KPiA+ICsJV0FSTl9PTighaXJxc19kaXNhYmxlZCgpICYmIGNwdV9hY3RpdmUoY3B1KSk7DQo+
ID4gwqANCj4gDQo+IEFsc28sIHRoZSBsb2dpYyBvZjoNCj4gDQo+IAkhaXJxc19kaXNhYmxlZCgp
ICYmIGNwdV9hY3RpdmUoY3B1KQ0KPiANCj4gaXMgcXVpdGUgd2VpcmQuDQo+IA0KPiBUaGUgb3Jp
Z2luYWwgIldBUk4oIWlycXNfZGlzYWJsZWQoKSkiIGlzIHJlYXNvbmFibGUgYmVjYXVzZSBpbiBT
VEFSVElORw0KPiBzZWN0aW9uDQo+IHRoZSBJUlEgaXMgaW5kZWVkIGRpc2FibGVkLg0KPiANCj4g
QnV0IHRoaXMgZG9lc24ndCBtYWtlIHNlbnNlIGFueW1vcmUgYWZ0ZXIgd2UgbW92ZSB0byBPTkxJ
TkUgc2VjdGlvbiwgaW4gd2hpY2gNCj4gSVJRIGhhcyBhbHJlYWR5IGJlZW4gZW5hYmxlZCAoc2Vl
IHN0YXJ0X3NlY29uZGFyeSgpKS7CoCBJSVVDIHRoZSBXQVJOX09OKCkNCj4gZG9lc24ndCBnZXQg
ZXhwbG9kZWQgaXMgcHVyZWx5IGJlY2F1c2UgdGhlcmUncyBhbiBhZGRpdGlvbmFsIGNwdV9hY3Rp
dmUoY3B1KQ0KPiBjaGVjay4NCj4gDQo+IFNvLCBhIG1vcmUgcmVhc29uYWJsZSBjaGVjayBzaG91
bGQgYmUgc29tZXRoaW5nIGxpa2U6DQo+IA0KPiAJV0FSTl9PTihpcnFzX2Rpc2FibGVkKCkgfHwg
Y3B1X2FjdGl2ZShjcHUpIHx8ICFjcHVfb25saW5lKGNwdSkpOw0KPiANCj4gT3Igd2UgY2FuIHNp
bXBseSBkbzoNCj4gDQo+IAlXQVJOX09OKCFjcHVfb25saW5lKGNwdSkgfHwgY3B1X2FjdGl2ZShj
cHUpKTsNCj4gDQo+IChiZWNhdXNlIEkgZG9uJ3Qga25vdyB3aGV0aGVyIGl0J3MgcG9zc2libGUg
SVJRIGNhbiBzb21laG93IGdldCBkaXNhYmxlZCBpbg0KPiBPTkxJTkUgc2VjdGlvbikuDQo+IA0K
PiBCdHcgYWJvdmUgaXMgcHVyZWx5IGJhc2VkIG9uIGNvZGUgYW5hbHlzaXMsIGJ1dCBJIGhhdmVu
J3QgZG9uZSBhbnkgdGVzdC4NCg0KSG1tLi4gSSB3YXNuJ3QgdGhpbmtpbmcgdGhvcm91Z2hseS4g
IEkgZm9yZ290IENQVSBjb21wYXRpYmlsaXR5IGNoZWNrIGFsc28NCmhhcHBlbnMgb24gYWxsIG9u
bGluZSBjcHVzIHdoZW4gbG9hZGluZyBLVk0uICBGb3IgdGhpcyBjYXNlLCBJUlEgaXMgZGlzYWJs
ZWQgYW5kDQpjcHVfYWN0aXZlKCkgaXMgdHJ1ZS4gIEZvciB0aGUgaG90cGx1ZyBjYXNlLCBJUlEg
aXMgZW5hYmxlZCBidXQgIGNwdV9hY3RpdmUoKSBpcw0KZmFsc2UuDQoNClNvIFdBUk5fT04oIWly
cXNfZGlzYWJsZWQoKSAmJiBjcHVfYWN0aXZlKGNwdSkpIGxvb2tzIHJlYXNvbmFibGUuICBTb3Jy
eSBmb3IgdGhlDQpub2lzZS4gIEp1c3QgbmVlZGVkIHNvbWUgdGltZSB0byBjb25uZWN0IHRoZSBj
b21tZW50IHdpdGggdGhlIGNvZGUuDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwprdm1hcm0gbWFpbGluZyBsaXN0Cmt2bWFybUBsaXN0cy5jcy5jb2x1bWJp
YS5lZHUKaHR0cHM6Ly9saXN0cy5jcy5jb2x1bWJpYS5lZHUvbWFpbG1hbi9saXN0aW5mby9rdm1h
cm0K
